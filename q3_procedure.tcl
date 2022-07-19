proc sec_struct_proportion {pdbfile frame_number} {
    set mol_id [mol load pdb $pdbfile]
    set sel_3 [atomselect $mol_id "all" frame $frame_number]
    set sec_struct [$sel_3 get {structure}]
    set n_structures [llength $sec_struct]
    set unique_structs [lsort -unique $sec_struct]
    foreach struct $unique_structs {dict set struct_proportion $struct 0.0}
    foreach struct $sec_struct {dict set struct_proportion $struct [expr 1+[dict get $struct_proportion $struct]]}
    foreach key [dict keys $struct_proportion] {dict set struct_proportion $key [expr [dict get $struct_proportion $key]/$n_structures*100]}
    puts $struct_proportion    
}
