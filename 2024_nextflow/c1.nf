# code from nextflow training website


process sayHello {

    output: 
        stdout
    
    """
    echo 'Hello World!'
    """
}

workflow {
    sayHello()  | view
}
