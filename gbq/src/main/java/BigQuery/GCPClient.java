package BigQuery;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Paths;
import java.util.Properties;
import java.util.UUID;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.bigquery.BigQuery;
import com.google.cloud.bigquery.BigQueryOptions;
import com.google.cloud.bigquery.Dataset;
import com.google.cloud.bigquery.FieldValueList;
import com.google.cloud.bigquery.Job;
import com.google.cloud.bigquery.JobId;
import com.google.cloud.bigquery.JobInfo;
import com.google.cloud.bigquery.QueryJobConfiguration;
import com.google.cloud.bigquery.TableResult;

public class GCPClient {

    private static Properties prop = null;

    /**
     * Logger.
     */
    public static final Logger LOG = LogManager.getLogger(GCPClient.class);

    public static String filePath = "/test-defaults.properties";

    public static String colStart;

    public static String colEnd;

    public static String tableStart;

    public static String tableEnd;

    public static String action;

    public static String tableName;

    public static String projectId;

    public static String gcpConfigPath;

    static {
        URL res = GCPClient.class.getResource(filePath);
        File file = null;
        try {
            file = Paths.get(res.toURI()).toFile();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        String absolutePath = file.getAbsolutePath();
        prop = readPropertiesFile(absolutePath);
        colStart = prop.getProperty("cols.start");
        colEnd = prop.getProperty("cols.end");
        tableStart = prop.getProperty("tables.start");
        tableEnd = prop.getProperty("tables.end");
        action = prop.getProperty("action");
        tableName = prop.getProperty("table.name");
        projectId = prop.getProperty("project.id");
        gcpConfigPath = prop.getProperty("gcp.config");
    }

    /**
     * @param fileName .
     * @return .
     * @throws IOException .
     */
    private static Properties readPropertiesFile(String fileName) {
        FileInputStream fis = null;
        Properties properties = null;
        try {
            fis = new FileInputStream(fileName);
            properties = new Properties();
            properties.load(fis);
        } catch (FileNotFoundException fnfe) {
            LOG.error("context {}", fnfe);
        } catch (IOException ioe) {
            LOG.error("context {}", ioe);
        } finally {
            try {
                if (fis != null) {
                    fis.close();
                }
            } catch (IOException e) {
                LOG.error("Failed to close stream");
            }
        }
        return properties;
    }

    /**
     * @return QueryConfig .
     */
    public static QueryJobConfiguration createTables(int i) {
        String str = "";
        for (int y = Integer.parseInt(colStart); y <= Integer.parseInt(colEnd); y++) {
            str += "col" + y + " int64,";
        }

        QueryJobConfiguration queryConfig = QueryJobConfiguration
                .newBuilder("CREATE TABLE " + tableName + i + "(" + str + ");")
                .setUseLegacySql(false).build();
        return queryConfig;
    }

    /**
     * @return QueryConfig .
     */
    public static QueryJobConfiguration dropTables(int i) {
        QueryJobConfiguration queryConfig = QueryJobConfiguration
                .newBuilder("DROP TABLE " + tableName + i).setUseLegacySql(false)
                .build();
        return queryConfig;
    }

    /**
     * @param args .
     * @throws Exception .
     */
    public static void main(String[] args) throws Exception {

        File credentialsPath = new File(gcpConfigPath);

        GoogleCredentials credentials;
        try (FileInputStream serviceAccountStream = new FileInputStream(credentialsPath)) {
            credentials = ServiceAccountCredentials.fromStream(serviceAccountStream);
        }

        // Instantiate a client.
        BigQuery bigquery = BigQueryOptions.newBuilder().setCredentials(credentials)
                .setProjectId(projectId).build().getService();

        // Use the client.
        System.out.println("Datasets:");
        for (Dataset dataset : bigquery.listDatasets().iterateAll()) {
            LOG.info(dataset.getDatasetId().getDataset());
        }

        for (int i = Integer.parseInt(tableStart); i <= Integer.parseInt(tableEnd); i++) {

            QueryJobConfiguration queryConfig;
            if ( action.equalsIgnoreCase("create")) {
                queryConfig = createTables(i);
            }else {
                queryConfig = dropTables(i);
            }

            // Create a job ID so that we can safely retry.
            JobId jobId = JobId.of(UUID.randomUUID().toString());
            Job queryJob = bigquery.create(JobInfo.newBuilder(queryConfig).setJobId(jobId).build());

            // Wait for the query to complete.
            queryJob = queryJob.waitFor();

            // Check for errors
            if (queryJob == null) {
                throw new RuntimeException("Job no longer exists");
            } else if (queryJob.getStatus().getError() != null) {
                throw new RuntimeException(queryJob.getStatus().getError().toString());
            }

            // Get the results.
            TableResult result = queryJob.getQueryResults();

            // Print all pages of the results.
            for (FieldValueList row : result.iterateAll()) {
                String url = row.get("url").getStringValue();
                long viewCount = row.get("view_count").getLongValue();
                LOG.info("url : " +  url + "views:" + viewCount);
            }
        }
    }
}
