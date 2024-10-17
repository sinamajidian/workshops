# workshops

This repo contains some code for learning NextFlow.


```
conda create -n next python=3.9
conda activate next
conda install bioconda::nextflow

$ nextflow -h                                                                                                                                    
Usage: nextflow [options] COMMAND [arg...]    
```


Example 1

```
$ cat code1.nf 


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
```

We can run this with `$ nextflow code1.nf`.

Output is 
```
$ nextflow code1.nf 

 N E X T F L O W   ~  version 24.04.4

Launching `code1.nf` [dreamy_poisson] DSL2 - revision: ae29f64ff1

executor >  local (1)
[a6/3a7d1c] sayHello [100%] 1 of 1 ✔
Hello World!
```

and files
```
$ ls -at
.nextflow.log  .nextflow  work  .  ..  code1.nf

$ ls -at work/a6/3a7d1ca12325bd1654b30dd50f743c/
.exitcode  .  .command.log  .command.out  .command.err  .command.begin  .command.sh  .command.run  ..
``` 
You can compare the name of folders with the line in the log file `[a6/3a7d1c] sayHello`. 


## Ex 2











