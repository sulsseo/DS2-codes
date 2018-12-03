SRC_FILE=MapReduce.java
INPUT_FILE=input.txt
HADOOP_HOMEWORK_DIR=task
HADOOP_INPUT_DIR=$(HADOOP_HOMEWORK_DIR)/input
HADOOP_OUTPUT_DIR=$(HADOOP_HOMEWORK_DIR)/output
USER_NAME=f181_trmaljak

all: clean prepare_working_dir compile run

clean:
	hadoop fs -rm -r -f /user/$(USER_NAME)/$(HADOOP_INPUT_DIR)
	hadoop fs -rm -r -f /user/$(USER_NAME)/$(HADOOP_OUTPUT_DIR)

prepare_working_dir:
	hadoop fs -mkdir -p /user/$(USER_NAME)/$(HADOOP_HOMEWORK_DIR)/
	hadoop fs -mkdir -p /user/$(USER_NAME)/$(HADOOP_INPUT_DIR)/
	hadoop fs -copyFromLocal $(INPUT_FILE) /user/$(USER_NAME)/$(HADOOP_INPUT_DIR)

compile:
	mkdir -p classes
	javac -classpath /home/NOSQL/FEL-B4M36DS2/mapreduce/hadoop-common-3.1.1.jar:/home/NOSQL/FEL-B4M36DS2/mapreduce/hadoop-mapreduce-client-core-3.1.1.jar -d classes/ MapReduce.java
	jar -cvf MapReduce.jar -C classes/ .

run:
	hadoop jar MapReduce.jar MapReduce /user/$(USER_NAME)/$(HADOOP_INPUT_DIR) /user/$(USER_NAME)/$(HADOOP_OUTPUT_DIR)
	hadoop fs -copyToLocal -f /user/$(USER_NAME)/$(HADOOP_OUTPUT_DIR)/part-r-00000 ./output.txt
