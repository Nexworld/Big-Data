Démonstration Hadoop 2.6
========================

Configuration
-------------

*Machine*: Ubuntu

*Installation* : Hadoop 2.6.0 + Hive + Pig

*Users:* “user:hduser|mdp:hduser”, “user:nexadmin|mdp:nexworld2015”

[*https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html\#Download*](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Download)

[*https://cwiki.apache.org/confluence/display/Hive/AdminManual+Installation*](https://cwiki.apache.org/confluence/display/Hive/AdminManual+Installation)

[*https://pig.apache.org/docs/r0.7.0/setup.html*](https://pig.apache.org/docs/r0.7.0/setup.html)

Prérequis
---------

Pour la démonstration, il faut se loguer en tant que hduser, Hadoop n’a
pas été installé pour les autres users.

Démonstrations

Créer un dossier hduser dans /user/ dans le hdfs : hadoop fs –mkdir
/user/hduser

Copier tous les fichiers/dossiers du github sur le bureau d’Ubuntu
(hive.sql, wordcount.pig, Hadoop-WordCount)

MAP REDUCE
----------

### Démarrage des services

*Fichiers de configuration : « /usr/local/hadoop/etc/hadoop »*,

Fichier de configuration HDFS : « hdfs-site.xml ».

Le répertoire du NameNode : « dfs.namenode.name.dir »

Le répertoire du DataNode : « dfs.datanode.name.dir »

Démarrer hdfs et yarn : commandes start-dfs.sh & start-yarn.sh
(utilisables car dans le PATH, sinon elles sont situées dans
/usr/local/hadoop/sbin).

*Quelques commandes pour illustrer l’utilisation du FileSystem :*

-   « hadoop fs –ls / » faire un ls sur le filesystem de hadoop

-   « hadoop fs –mkdir /usr/test » : création d’un répertoire

-   « hadoop fs –rmdir /usr/test”: supprimer fichier

Liste des commandes
[*http://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-common/FileSystemShell.html*](http://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-common/FileSystemShell.html)

### Exécution de MapReduce

Aller à l’endroit où se trouve le jar d’exécution du wordcount :

« cd /&lt;path&gt; /Hadoop-WordCount »

Vous pouvez visualiser ici la classe WordCount.java (Ouvrir avec gedit
pour une meilleure lisibilité)

Transférer le fichier input vers le filesystem Hadoop : “hadoop fs -put
/&lt;path&gt;/Hadoop-WordCount/input/ /user/hduser/”

*Interface d’administration HDFS :* http://localhost:50070

“hadoop fs -cat /user/hduser/input/\*” : lire le contenu du fichier

*Execution du Wrodcount :* hadoop jar wordcount.jar WordCount
/user/hduser/input /user/hduser/output

*Administration Hadoop pour voir les applications qui sont lancées :*
http://hadoop:8088/cluster

Si le dossier “output” est déjà présent : “hadoop fs -rm -r
/user/hduser/output »

Vérification de la présence du résultat du wordcount : hadoop fs -cat
/user/hduser/output/\*

Spark
-----

cd /home/nexadmin/Desktop/spark-1.2.1-bin-hadoop2.4

./bin/spark-shell

var file =
sc.textFile("hdfs://localhost:9000/user/hduser/input/Word\_Count\_input.txt")

var count = file.flatMap(line =&gt; line.split(" ")).map(word =&gt;
(word, 1)).reduceByKey(\_+\_)

count.saveAsTextFile("hdfs://localhost:9000/user/hduser/spark\_wordcount")

hadoop fs -cat /user/hduser/spark\_wordcount/\*

PIG
---

Aller dans le dossier où se trouve le fichier pig (cd
/&lt;path&gt;/Desktop)

Examiner le code PIG : vim wordcount.pig

Lancer le script : “pig -f /&lt;path&gt;/wordcount.pig”

hadoop fs –cat /user/hduser/pigwordcount/\*

HIVE
----

Examiner le code Hive : vim hive.sql

Etape 7 : hive -f hive.sql

hive

select \* from wordcount;

select \* from pig\_wordcount where count &gt; 100 ;

select count, count(\*) from wordcount group by count;

select pig\_wordcount.word, pig\_wordcount.count + wordcount.count from
pig\_wordcount join wordcount on wordcount.word = pig\_wordcount.word;

quit;

Démonstration Hortonworks
-------------------------

3 interfaces :

-   HUE (Hadoop User Experience) : 127.0.0.1:8000 – User : Hue/1111

    -   Interface Hive, Pig, Oozie etc.

-   Ambari : 127.0.0.1:8080 | admin admin

    -   Monitoring Hadoop

-   Ranger : 127.0.0.1:6080 | admin admin

    -   Centralise les fonctionnalités de sécurisation


