import pytraj as pt

#modify me:  Attention, modify the masks in the body of the code!
###########################################################
###########################################################
#trajectory info
start = 2500
stop  = 2950
every = 50
trajectory='../../../1-408cent1_skip100.nc'
topology='../../../PHYb_ff14.prmtop'
stripmask=':505-1008,Na+'

#solvmask is the mask for the atom around which you can keep the closest waters
solvmask=':504@CHC'
wat2keep=390
##########################################################
##########################################################


traj = pt.iterload(trajectory, top = topology)
top = pt.load_topology(topology)

stripped_prm = pt.strip(top, mask= stripmask)
stripped_traj = pt.strip(traj, stripmask)
print stripmask, "stripped"

print "selecting closest", wat2keep, "water molecules ..."
closest_traj = pt.closest(stripped_traj, mask=solvmask, n_solvents= wat2keep, dtype = 'trajectory')


# NOTE: framelist here starts from zero!
framelist = range( start - 1 , stop , every)

for frame in framelist:
    # NOTE: output files have numbering starting from one!


    name = 'closest_%04d.mol2' % (frame + 1)
    print " ... writing frame %s" % (name)
    pt.save(name,closest_traj,options='single',overwrite=True,frame_indices=[frame])
   


