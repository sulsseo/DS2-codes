import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;

import java.io.File;

/**
 * Desctiption
 *
 * @author: Jakub Trmal - trmaljak@fel.cvut.cz
 * @since: 2019-01-07
 */
public class Database {
    GraphDatabaseService db = new GraphDatabaseFactory()
            .newEmbeddedDatabase(new File("MyNeo4jDB"));

}
