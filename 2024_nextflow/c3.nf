
# https://nextflow-io.github.io/patterns/publish-process-outputs/
params.in = "$baseDir/sample.fa"
params.outdir = "results"


process splitSequences {

    input:
    path 'input.fa'

    output:
    path 'seq_*'

    """
    awk '/^>/{f="seq_"++d} {print > f}' < input.fa
    """
}

process reverse {

    publishDir "$params.outdir"
    input:
    path x

    output:
    path '*.txt'

    """
    cat $x | rev > out.txt
    """
}

workflow {
    splitSequences(params.in) | reverse  | view
}
