from pymol import cmd
import itertools


def pairwise_rmsd(obj_list):
    rmsd_values = []
    n = len(obj_list)

    for i in range(n):
        for j in range(i+1, n):  # ensures no repeats and no self-comparison
            obj1, obj2 = obj_list[i], obj_list[j]

            # Compute RMSD without fitting, cycles=0
            rmsd = cmd.align(obj1, obj2, cycles=0, transform=0)[0]
            #print(f"RMSD between {obj1} and {obj2}: {rmsd:.3f}")
            rmsd_values.append(rmsd)

    print(rmsd_values)
    # Calculate average RMSD
    if rmsd_values:
        avg_rmsd = sum(rmsd_values) / len(rmsd_values)
        print(f"\nAverage RMSD across {len(rmsd_values)} pairs: {avg_rmsd:.3f}")
        return avg_rmsd
    else:
        print("No RMSD values calculated (need at least 2 objects).")
        return None


# Example usage:
# Get all object names in the current PyMOL session
object_names = cmd.get_object_list('all')

# Print the list of object names
print(object_names)
pairwise_rmsd(object_names)

## on pyMOL terminal:
## --> run rmsd_test2.py 
## Average RMSD calculated from all pairwise RMSD measurements across objects in the PyMOL window.
