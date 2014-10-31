#generate a sequence file from your articles
mahout seqdirectory -i ${WORK_DIR}/data -o ${WORK_DIR}/mahout/text_sequence -c UTF-8 -xm sequential
#Generate vectors
mahout seq2sparse -nv   -i  ${WORK_DIR}/mahout/text_sequence -o   ${WORK_DIR}/mahout/text_vector --maxDFPercent 85 --namedVector
#Run K-means
 mahout kmeans -i ${WORK_DIR}/mahout/text_vector/tfidf-vectors/ -o ${WORK_DIR}/mahout/text_clusters/ -c mahout-initial-centers -dm org.apache.mahout.common.distance.CosineDistanceMeasure --clustering  -cl  -cd  0.1  -b 100 -x  10  -k  20  -ow
#Save output to text file on local computer
mahout clusterdump -d ${WORK_DIR}/mahout/text_vector/dictionary.file-0 -dt sequencefile -i ${WORK_DIR}/mahout/text_cluster/clusters-* -o ~/Documents/mahout/text_dump/dump.txt -n 20
#Run Fuzzy K-means
 mahout kmeans -i ${WORK_DIR}/mahout/text_vector/tfidf-vectors/ -o ${WORK_DIR}/mahout/text_clusters_fkmeans/ -c mahout-initial-centers -dm org.apache.mahout.common.distance.CosineDistanceMeasure --clustering  -cl  -cd  0.1  -x  10  -k  20  -m 1.1  -ow
#Save output to text file on local computer
mahout clusterdump -d ${WORK_DIR}/mahout/text_vector/dictionary.file-0 -dt sequencefile -i ${WORK_DIR}/mahout/text_clusters_fkmeans/clusters-* -o ${WORK_DIR}/mahout/text_dump/dump.txt -n 20
#Run Streaming Kmeans
 mahout streamingkmeans -i ${WORK_DIR}/mahout/text_vector/tfidf-vectors/ -o ${WORK_DIR}/mahout/text_clusters_streamkmeans/ -sc org.apache.mahout.math.neighborhood.FastProjectionSearch -dm org.apache.mahout.common.distance.SquaredEuclideanDistanceMeasure  -k 10 -km 100 -ow 
#Save output to text file on local computer
mahout qualcluster  -i ${WORK_DIR}/mahout/wiki/text_vector/tfidf-vectors/part-r-00000  -c ${WORK_DIR}/mahout/wiki/text_clusters_streamkmeans/part-r-00000  -o ${WORK_DIR}/mahout/wiki/streamkmeans-cluster-distance.csv 

