#!/bin/sh

# How to submit

# XXX - haven't handled lsf-mpirun or msub-torque-pdsh yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

# Tests to run

defaulttests=y
hadooptests=y
pigtests=y
hbasetests=y
sparktests=y
stormtests=y
zookeepertests=y

dependencytests=y

largeperformanceruntests=n

if [ "${submissiontype}" == "sbatch-srun" ]
then
    jobsubmitcmd="sbatch"
    jobsubmitcmdoption="-k"
    jobsubmitdependency="--dependency=afterany:\${prev}"
    jobidstripcmd="awk '""{print \$4}""'"
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    jobsubmitcmd="msub"
    jobsubmitcmdoption=""
    jobsubmitdependency="-l depend=\${prev}"
    jobidstripcmd="xargs"
fi

# Default Tests

if [ "${defaulttests}" == "y" ]
then
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hbase-with-hdfs
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-spark
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-spark-with-hdfs
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-zookeeper

    # Default No Local Dir Tests

    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hbase-with-hdfs-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-spark-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-spark-with-hdfs-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-no-local-dir
    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-zookeeper-no-local-dir

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.4.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.4.0-pig-0.14.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.6.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.6.0-pig-0.14.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.7.1`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.7.1-pig-0.15.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-spark-1.4.1-bin-hadoop2.6`
    fi
fi

# Hadoop Tests

if [ "${hadooptests}" == "y" ]
then
    for hadoopversion in 2.7.1
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-multiple-paths
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-multiple-paths

	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-multiple-paths-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-multiple-paths-no-local-dir

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    ${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    for hadoopversion in 2.6.0
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-multiple-paths
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-multiple-paths
	
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-multiple-paths-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-no-local-dir
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-multiple-paths-no-local-dir

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    ${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    for hadoopversion in 2.4.0
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfs-multiple-paths
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-localstore-multiple-paths

	if [ "${largeperformanceruntests}" == "y" ]
	then
	    ${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun
	fi
    done

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-upgradehdfs`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-hdfs-older-version`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-upgradehdfs`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-more-nodes`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-fewer-nodes`
	
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-more-nodes`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-fewer-nodes`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-more-nodes`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-fewer-nodes`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4A`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4A-hdfs-newer-version`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4B`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4B-hdfs-newer-version`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5A`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfs-newer-version`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5B`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5B-hdfs-newer-version`
    fi
fi
    
# Pig Tests

if [ "${pigtests}" == "y" ]
then
    for pigversion in 0.15.0
    do
	for hadoopversion in 2.7.1
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-pig-script
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-pig-script-no-local-dir
	done
    done
    
    for pigversion in 0.14.0
    do
	for hadoopversion in 2.6.0
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-pig-script-no-local-dir
	done
    done
    
    for pigversion in 0.12.0 0.14.0
    do
	for hadoopversion in 2.4.0 2.6.0
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-hadoop-and-pig-${pigversion}-hadoop-${hadoopversion}-pig-script
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0`
	
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0`
	
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0`
    fi
fi

# Hbase Tests

if [ "${hbasetests}" == "y" ]
then
    for hbaseversion in 0.99.2 1.1.1 1.1.2 
    do
	for hadoopversion in 2.7.1 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local
		
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    done
	done
    done

    for hbaseversion in 0.98.9-hadoop2
    do
	for hadoopversion in 2.6.0 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-local-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-no-local-dir
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    done
	done
    done

    for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
    do
	for hadoopversion in 2.4.0 2.6.0 
	do
	    for zookeeperversion in 3.4.5 3.4.6
	    do
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-local
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared
		${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-${hbaseversion}-hadoop-${hadoopversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local
	    done
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6`
    fi
fi

# Spark Tests

if [ "${sparktests}" == "y" ]
then

    for sparkversion in 1.4.1-bin-hadoop2.6
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-${sparkversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-${sparkversion}-no-local-dir
    done

    # only b/c this is Spark only w/o Hadoop 2.4
    for sparkversion in 1.3.0-bin-hadoop2.4 
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-${sparkversion}-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-${sparkversion}
    done

    for sparkversion in 1.4.1-bin-hadoop2.6
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0
    done

    for sparkversion in 1.4.1-bin-hadoop2.6
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-no-local-dir
    done

    for sparkversion in 0.9.1-bin-hadoop2 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
    done

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6`
    fi
fi

# Storm Tests

if [ "${stormtests}" == "y" ]
then

    for stormversion in 0.9.5
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-local
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	    
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-local-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	done
    done

    for stormversion in 0.9.4
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-local-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-no-local-dir
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	done
    done

    for stormversion in 0.9.3 0.9.4
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-local
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared
	    ${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	done
    done

    if [ "${dependencytests}" == "y" ]
    then
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6`

	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6`
	jobidstripfullcommand="echo ${jobsubmitoutput} | ${jobidstripcmd}"
	prev=`eval ${jobidstripfullcommand}`
	jobsubmitdependencyexpand=`eval echo ${jobsubmitdependency}`
	jobsubmitoutput=`${jobsubmitcmd} ${jobsubmitcmdoption} ${jobsubmitdependencyexpand} magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6`
    fi
fi

# Zookeeper Tests

if [ "${zookeepertests}" == "y" ]
then
    for zookeeperversion in 3.4.5 3.4.6
    do
	${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-zookeeper-${zookeeperversion}
	${jobsubmitcmd} ${jobsubmitcmdoption} ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local
    done

    if [ "${dependencytests}" == "y" ]
    then
	echo "No Zookeeper Dependency Tests"
    fi
fi
