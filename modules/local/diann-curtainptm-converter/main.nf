process DIANN_CURTAINPTM_CONVERTER {
    label 'process_medium'

    container "${ workflow.containerEngine == 'singularity' ?
        'docker://cauldron/diann-curtainptm-converter:1.0.0' :
        'cauldron/diann-curtainptm-converter:1.0.0' }"

    input:
    path pr_file
    path report_file
    val modification_type
    path fasta_file
    val localization_score_col
    val multiple_site
    val uniprot_columns
    val output_filename
    val output_meta
    val sequence_window_size

    output:
    
    path "*.txt", emit: converted_file, optional: true
    path "versions.yml", emit: versions

    script:
    def args = task.ext.args ?: ''
    """
    # Build arguments dynamically to match CauldronGO PluginExecutor logic
    ARG_LIST=()

    
    python /app/convert.py \
        "\${ARG_LIST[@]}" \
        --output_folder . \
        \${args:-}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        DIA-NN to CurtainPTM Converter: 1.0.0
    END_VERSIONS
    """
}
