import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.StringTokenizer;

public class MapReduce {

    public static class TokenizerMapper
            extends Mapper<Object, Text, Text, FloatWritable> {

        @Override
        public void map(Object key, Text value, Context context)
                throws IOException, InterruptedException {

            String[] lines = value.toString().split("\n");
            for (String line : lines) {
                String[] data = line.split(";");

                StringTokenizer st = new StringTokenizer(data[4],"-");
                LocalDate date = LocalDate
                        .of(Integer.parseInt(st.nextToken()),
                            Integer.parseInt(st.nextToken()),
                            Integer.parseInt(st.nextToken()));

                // compute bike age
                float age =
                        (float) ChronoUnit.DAYS.between(date,LocalDate.now());

                context.write(new Text(data[1]), new FloatWritable(age));
            }
        }
    }

    public static class AvgReducer
            extends Reducer<Text, FloatWritable, Text, FloatWritable> {

        @Override
        public void reduce(Text key,
                           Iterable<FloatWritable> values,
                           Context context)
                throws IOException, InterruptedException {

            float sum = 0;
            float elements = 0;
            for (FloatWritable v : values) {
                sum += v.get();
                elements++;
            }
            FloatWritable avg = new FloatWritable(sum/elements);
            context.write(key, avg);

        }

    }

    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "MapReduce");

        job.setJarByClass(MapReduce.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setReducerClass(AvgReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(FloatWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}
