
$ cat c4.nf 


process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting  

    output: 
        path "${greeting}-output.txt"
    
    """
    echo '$greeting' > '$greeting-output.txt'
    """
}



process convertToUpper {
    publishDir 'results'
    input:
        path input_file

    output:
        path "UPPER-${input_file}"

    """
    cat '$input_file' | tr '[a-z]' '[A-Z]' > UPPER-${input_file}
    """
}

workflow {


    greeting_ch = Channel.of('Hello', 'Bonjour', 'Hola')
    outsay = sayHello(greeting_ch)
    outsay.view { "out is : ${it}" }   
   convertToUpper(outsay)
}
