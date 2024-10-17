# workshops


We want to talk about NextFlow

<img src="https://raw.githubusercontent.com/nextflow-io/nextflow/master/docs/_static/nextflow-logo-bg-light.png" width="600"/>



NextFlow is a workflow system for creating scalable, portable, and reproducible workflows. Nextlow publication in [Nature Biotech](https://www.nature.com/articles/nbt.3820). 
It is useful whn there are a number of steps to analyse data and steps (software or scripts are linked by input/output.

Once we have the workflow, we can run on it for several samples in parallel, considering the dependency.

Nextflow has [documentation](https://www.nextflow.io/docs/latest/index.html) and holds workshops available on [YouTube](https://www.youtube.com/@Nextflow). There is an active Slack workspace that you can ask questions [here](https://www.nextflow.io/slack-invite.html).



This is an example of NextFlow dependency graph of the [FastOMA](https://github.com/DessimozLab/FastOMA), a tool for orthology inference. 


<img src="https://github.com/user-attachments/assets/3e7d0f54-b8ee-4a46-bf75-1b2496d88aba" width="300"/>

### installation
You can install


```
conda create -n next python=3.9
conda activate next
conda install bioconda::nextflow

$ nextflow -h                                                                                                                                    
Usage: nextflow [options] COMMAND [arg...]    
```


### Example one

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











