#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 16 16:09:56 2024

@author: chingchinglam
"""

from Bio.PDB import PDBParser
import numpy as np
import os
from natsort import natsorted
from collections import defaultdict
import pandas as pd
from datetime import date

def parse_ligand_conformations(file_path):
    """
    Parse a PDBQT file to extract nitrogen (N) atom coordinates for each conformation.
    Args:
        file_path (str): Path to the ligand PDBQT file.
    Returns:
        list: A list of numpy arrays, each representing nitrogen coordinates for a conformation.
    """
    conformations = []
    current_conformation = []
    
    with open(file_path, "r") as file:
        for line in file:
            if line.startswith("MODEL"):  # Start of a new conformation
                if current_conformation:  # Save previous conformation
                    #conformations.append(current_conformation)
                    current_conformation = []
            elif line.startswith("ATOM") and line[77:78].strip() == "N":
                # Extract nitrogen atom coordinates
                x, y, z = map(float, [line[30:38], line[38:46], line[46:54]])
                current_conformation.append(np.array([x, y, z]))
            elif line.startswith("ENDMDL"):  # End of a conformation
                if current_conformation:
                    conformations.append(current_conformation)

    return conformations

def ligand_centroid(file_path):

    conformations = []
    current_conformation = []
    
    with open(file_path, "r") as file:
        for line in file:
            if line.startswith("MODEL"):  # Start of a new conformation
                if current_conformation:  # Save previous conformation
                    #conformations.append(current_conformation)
                    current_conformation = []
            elif line.startswith("ATOM"):
                x, y, z = map(float, [line[30:38], line[38:46], line[46:54]])
                current_conformation.append(np.array([x, y, z]))
            elif line.startswith("ENDMDL"):  # End of a conformation
                if current_conformation:
                    conformations.append(current_conformation)

    mean_coord=[np.mean(c, axis=0) for c in conformations]

    return [np.linalg.norm(np.array([0,0,0]) - centroid) for centroid in mean_coord]


def protein_centroid(pdbfile,residue_ls,chain_id='A'):

    parser = PDBParser(QUIET=True)
    structure = parser.get_structure("protein",pdbfile)
    model = structure[0]
    
    residue_info_ls=[]
    for res in residue_ls:
        try:
            residue = model[chain_id][res]
            residue_info_ls.append(residue)
        except KeyError:
            print(f"Residue ID {res} in chain {chain_id} not found.")
            print("choose from below:")
            for chain in model:
                print(f"Chain ID: '{chain.id}'")
    
    residue_atom_coord=[]
    for residue in residue_info_ls:
        for atom in residue:
            residue_atom_coord.append(atom.coord)
    
    centroid = np.mean(residue_atom_coord, axis=0)

    return centroid


class analyse_vina:
    def __init__(self,path):
        self.path=path

    def analyse(self,keyword, residue_ls, chain_id='A', center_cutoff=5,N_cutoff=6):

        self.keyfolder=self.path+'/'+keyword+'/'
        self.keyword =keyword

        self.protein_ls = natsorted([f[:-4] for f in os.listdir(self.keyfolder) if f.endswith('_H.pdb')])
        self.vina_result_ls=[]
        for protein in self.protein_ls:
            self.vina_result_ls.append(natsorted([f[:-6] for f in os.listdir(self.keyfolder) if f.startswith(protein) and f.endswith('_vina.pdbqt')]))
        
        
        
        self.formatted_output_ls=[]
        
        for protein,vina_ls in zip(self.protein_ls,self.vina_result_ls):
        
            bingo_ls = []  # List for the current residue
            for ligand_file in vina_ls:
                protein_coords=protein_centroid(self.keyfolder+protein+'.pdb',residue_ls,chain_id=chain_id)
                ligand_conformations=parse_ligand_conformations(self.keyfolder+ligand_file+'.pdbqt')
                ligand_cent_dis_ls=ligand_centroid(self.keyfolder+ligand_file+'.pdbqt')
                    
                N_distances_ls = []
                for conformation in ligand_conformations:
                    distance = np.linalg.norm(protein_coords - conformation)
                    N_distances_ls.append(distance)
            
                result_ls=[[ligand_cent_dis,N_dis] for ligand_cent_dis,N_dis in zip(ligand_cent_dis_ls, N_distances_ls)]
            
                for index, distance in enumerate(result_ls):
            
                    if distance[0] < center_cutoff and distance[1] < N_cutoff:
                            # Append vina and the index to bingo_ls
                        bingo_ls.append((ligand_file, index, distance[1]))
            
            # Create a dictionary to group by ligand file and store (index, distance[1])
            summary = defaultdict(list)
            for name, index, dist in bingo_ls:
                summary[name].append((index + 1, dist))  # Add 1 to index to match 1-based indexing
            
            # Sort the indices based on distance[1] for each ligand file
            formatted_output = [(key, [index for index, _ in sorted(value, key=lambda x: x[1])])  # Sort by distance[1]
                for key, value in summary.items()]
        
            self.formatted_output_ls.append(formatted_output)
    
    def gen_pivot(self):
        
        
        existing_combinations = set(
            (ligand.split('__')[1], protein)  # Only consider the part after '__'
            for protein, sublist in zip(self.protein_ls, self.formatted_output_ls)
            for ligand, _ in sublist
        )
        
        # Generate all possible combinations of ligands and proteins
        all_combinations = []
        for protein, ligands in zip(self.protein_ls, self.vina_result_ls):
            for ligand in ligands:
                # Remove the part before '__' in the ligand name
                ligand_name = ligand.split('__')[1] if '__' in ligand else ligand
                all_combinations.append((ligand_name, protein))
        
        # Create a list of all unique ligands (after removing the part before '__')
        ligands = list(set([comb[0] for comb in all_combinations]))
        
        # Create the pivot table data
        pivot_data = {protein: [] for protein in self.protein_ls}
        
        for ligand in ligands:
            for protein in self.protein_ls:
                # Check if the combination (ligand, protein) exists in the formatted_output_ls (after splitting at __)
                if (ligand, protein) in existing_combinations:
                    pivot_data[protein].append("o")
                else:
                    pivot_data[protein].append("x")
        
        self.pivot_table = pd.DataFrame(pivot_data, index=ligands)
                
                
    def gen_pivot_adv(self, reidx=False, custom_order=[], save_csv=True):
        
        existing_combinations = {
            (ligand.split('__')[1], protein): indices  # Store indices (second item in the tuple) in the set
            for protein, sublist in zip(self.protein_ls, self.formatted_output_ls)
            for ligand, indices in sublist
        }
        
        # Generate all possible combinations of ligands and proteins
        all_combinations = []
        for protein, ligands in zip(self.protein_ls, self.vina_result_ls):
            for ligand in ligands:
                # Remove the part before '__' in the ligand name
                ligand_name = ligand.split('__')[1] if '__' in ligand else ligand
                all_combinations.append((ligand_name, protein))
        
        # Create a list of all unique ligands (after removing the part before '__')
        ligands = list(set([comb[0] for comb in all_combinations]))
        
        # Create the pivot table data
        pivot_data = {protein: [] for protein in self.protein_ls}
        
        for ligand in ligands:
            for protein in self.protein_ls:
                # Check if the combination (ligand, protein) exists in the formatted_output_ls (after splitting at __)
                if (ligand, protein) in existing_combinations:
                    # If combination exists, store the corresponding index list
                    pivot_data[protein].append(existing_combinations[(ligand, protein)])
                else:
                    # If combination does not exist, append an empty list or NaN
                    pivot_data[protein].append([])  # or you can use `None` or `pd.NA` if preferred
        
        # Create the DataFrame
        self.pivot_table = pd.DataFrame(pivot_data, index=ligands)

        if reidx == True:
            
            self.summary = self.pivot_table.reindex(custom_order)


        else: 
            self.summary = self.pivot_table


        if save_csv == True:

            today = date.today()
            date_str=today.strftime("%d%m%Y")

            self.summary.to_csv('summary'+'_'+self.keyword+'.csv')
# Create the DataFrame
            
# Usage Example

'''
from analyse_vina_PfB import analyse_vina
import pandas as pd
import os

path= os.getcwd()
residue_ls=[88,118,120,21,122]

test=analyse_vina(path)

test.analyse('test_vina', residue_ls, chain_id='A',center_cutoff=6,N_cutoff=6)

test.gen_pivot_adv(save_csv=False)
test.summary


'''
            
