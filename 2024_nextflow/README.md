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

This example include a process, which is a "basic processing primitive to execute a user script" and can have input/output/script.
A workflow is a composition of processes, channels and operators.

```
$ cat c1.nf 

// this is a comment

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

We can run this with `$ nextflow code1.nf`. The output is 
```
$ nextflow code1.nf 
 N E X T F L O W   ~  version 24.04.4
Launching `c1.nf` [dreamy_poisson] DSL2 - revision: ae29f64ff1
executor >  local (1)
[a6/3a7d1c] sayHello [100%] 1 of 1 ✔
Hello World!
```

and the output files are
```
$ ls -at
.nextflow.log  .nextflow  work  .  ..  code1.nf

$ ls -at work/a6/3a7d1ca12325bd1654b30dd50f743c/
.exitcode  .  .command.log  .command.out  .command.err  .command.begin  .command.sh  .command.run  ..
``` 
You can compare the name of folders with the line in the log file `[a6/3a7d1c] sayHello`. 


## Ex 2

```
$ cat sample.fa 
>A
aaaaaaaaaaaaaaacccccccccc
>B
gggggggggtttttttt
```

And we have this code including two processes

```
params.in = "$baseDir/sample.fa"

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

    input:
    path x

    output:
    stdout

    """
    cat $x | rev
    """
}

workflow {
    splitSequences(params.in) | reverse  | view
}
```

The output is 
```
$ nextflow c2.nf 
 N E X T F L O W   ~  version 24.04.4
Launching `c2.nf` [angry_bartik] DSL2 - revision: 9e48e57c59

executor >  local (2)
[ae/cdf5d5] splitSequences [100%] 1 of 1 ✔
[c4/baeff7] reverse        [100%] 1 of 1 ✔
A>
ccccccccccaaaaaaaaaaaaaaa
B>
ttttttttggggggggg
```

## example 3 
Let's write the output in a file. First add `params.outdir = "results"` in the begining and change the output of `reverese` to `path '*.txt'` 


```
$ nextflow c3.nf 
 N E X T F L O W   ~  version 24.04.4
Launching `c3.nf` [elegant_boyd] DSL2 - revision: 15963bc258
executor >  local (2)
[81/14f741] splitSequences [100%] 1 of 1 ✔
[05/10c9a7] reverse        [100%] 1 of 1 ✔
/vast/1/work/05/10c9a70874f46fc6dc3067f27ec9e5/out.txt


$ ls -ath  work/05/10c9a70874f46fc6dc3067f27ec9e5/
.exitcode  .  out.txt  .command.out  .command.err  seq_2  seq_1  .command.begin  .command.log  .command.sh  .command.run  ..

$ ls results/
out.txt
$ cat results/out.txt 
A>
ccccccccccaaaaaaaaaaaaaaa
B>
ttttttttggggggggg
```















