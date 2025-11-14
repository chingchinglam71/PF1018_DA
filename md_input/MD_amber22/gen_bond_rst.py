from Bio.PDB import PDBParser
import math

def calculate_distance(coord1, coord2):
    """Calculate the distance between two 3D coordinates."""
    return math.sqrt((coord1[0] - coord2[0])**2 + (coord1[1] - coord2[1])**2 + (coord1[2] - coord2[2])**2)

def generate_restraint_file(pdb_file, atom_pairs, output_file="restraints.RST"):
    """
    Generate a restraint file to freeze bond lengths for given atom pairs.

    Parameters:
        pdb_file (str): Path to the PDB file.
        atom_pairs (list): List of atom pairs in the format [[':155@C20', ':155@C3'], ...].
        output_file (str): Path to the output restraint file.
    """
    parser = PDBParser(QUIET=True)
    structure = parser.get_structure("structure", pdb_file)

    restraints = []

    for pair in atom_pairs:
        atom1_id, atom2_id = pair

        # Parse residue and atom information
        res1_info, atom1_name = atom1_id.split("@")
        res2_info, atom2_name = atom2_id.split("@")

        chain1_id, res1_num = res1_info.split(":")
        chain2_id, res2_num = res2_info.split(":")

        res1_num = int(res1_num)
        res2_num = int(res2_num)

        # Locate the atoms in the structure
        atom1 = structure[0][chain1_id][res1_num][atom1_name]
        atom2 = structure[0][chain2_id][res2_num][atom2_name]

        # Calculate bond length
        distance = calculate_distance(atom1.coord, atom2.coord)

        # Define restraint parameters
        r1 = distance - 0.2
        r2 = distance - 0.1
        r3 = distance + 0.1
        r4 = distance + 0.2
        rk2 = 1000.0
        rk3 = 1000.0

        # Format the restraint
        restraint = (
            f"&rst\n"
            f"   ixpk=0, nxpk=0, iat={atom1.serial_number},{atom2.serial_number}, r1={r1:.4f}, r2={r2:.4f},\n"
            f"   r3={r3:.4f}, r4={r4:.4f}, rk2={rk2}, rk3={rk3},\n"
            f"&end\n"
        )

        restraints.append(restraint)

    # Write restraints to file
    with open(output_file, "w") as f:
        f.writelines(restraints)

    print(f"Restraint file generated: {output_file}")




pdb_file = 'Test_TS.pdb'
atom_pairs = [[' :155@C12',' :155@C1'],[' :155@C11',' :155@C4']]

generate_restraint_file(pdb_file, atom_pairs, output_file="restraints.RST")


