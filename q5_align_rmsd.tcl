proc align_rmsd {pdbfile} {
    set mol_id [mol load pdb $pdbfile]
    set sel_5 [atomselect $mol_id "all" frame 0]
    set n_frames [molinfo top get numframes]
    
    for {set frame_idx 0} {$frame_idx < $n_frames} {incr frame_idx} { 
        set cur_frame [atomselect $mol_id "all" frame $frame_idx]
        set transform_matrix [measure fit $cur_frame $sel_5]
        $cur_frame move $transform_matrix
        set rmsd [measure rmsd $cur_frame $sel_5] 
        puts "Frame: $frame_idx | rmsd: $rmsd"
    }
}
