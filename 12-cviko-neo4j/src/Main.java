import org.neo4j.graphdb.*;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.graphdb.traversal.*;

import java.io.File;
import java.util.Iterator;
import java.util.Map;

/**
 * Desctiption
 *
 * @author: Jakub Trmal - trmaljak@fel.cvut.cz
 * @since: 2019-01-07
 */
public class Main {

    private GraphDatabaseService db;

    public Main() {
        db = new GraphDatabaseFactory()
                .newEmbeddedDatabase(new File("MyNeo4jDB"));
    }

    private void shutdown() {
        db.shutdown();
    }

    private Node createNode(String id, String name, int year, String label) {
        Transaction tx = db.beginTx();
        try {
            Node n = db.createNode();
            n.setProperty("id", id);
            n.setProperty("name", name);
            n.setProperty("year", year);
            n.addLabel(Label.label(label));
            tx.success();
            return n;
        } catch (Exception e) {
            tx.failure();
            return null;
        } finally {
            tx.close();
        }
    }

    private Relationship createRelationship(Node n1, Node n2, RelationshipType r) {
        Transaction tx = db.beginTx();
        try {
            Relationship re = n1.createRelationshipTo(n2, r);
            tx.success();
            return re;
        } catch (Exception e) {
            tx.failure();
            return null;
        } finally {
            tx.close();
        }

    }

    private void traversal(Node actor) {
        Transaction tx = db.beginTx();
        try {
            TraversalDescription td = db.traversalDescription()
                    .breadthFirst()
                    .relationships(MyType.KNOW, Direction.BOTH)
                    .evaluator(Evaluators.excludeStartPosition())
                    .uniqueness(Uniqueness.NODE_GLOBAL);
            Traverser t = td.traverse(actor);
            for (Path p : t) {
                System.out.println(p.endNode().getProperty("name"));
            }
            tx.success();
        } catch (Exception e) {
            tx.failure();
        } finally {
            tx.close();
        }
    }

    private void singleQuery() {
        Transaction tx = db.beginTx();
        try {
            Result result = db.execute("MATCH (n:MOVIE) RETURN n");
            while (result.hasNext()) {
                Map<String, Object> row = result.next();
                Node n = (Node) row.get("n");
                System.out.println(n.getProperty("name"));
            }
            tx.success();
        } catch (Exception e) {
            tx.failure();
        } finally {
            tx.close();
        }
    }

    private void evaluate() {
        Transaction tx = db.beginTx();
        try {
            TraversalDescription td = db.traversalDescription();
            td.evaluator(new MyEvaluator());
            tx.success();
        } catch (Exception e) {
            tx.failure();
        } finally {
            tx.close();
        }
    }

    class MyEvaluator implements Evaluator {
        @Override
        public Evaluation evaluate(Path path) {

            return null;
        }
    }

    public static void main(String[] args) {
        Main m = new Main();
//        Node a1 = m.createNode("trojan", "Ivan Trojan", 1964, "ACTOR");
//        Node a2 = m.createNode("machacek", "Jiri Machacek", 1966, "ACTOR");
//        Node a3 = m.createNode("schneiderova", "Jitka Schneiderova", 1973, "ACTOR");
//        Node a4 = m.createNode("sverak", "Zdenek Sverak", 1936, "ACTOR");
//
//        m.createRelationship(a1, a2, MyType.KNOW);
//        m.createRelationship(a1, a3, MyType.KNOW);
//        m.createRelationship(a2, a1, MyType.KNOW);
//        m.createRelationship(a2, a3, MyType.KNOW);
//        m.createRelationship(a4, a2, MyType.KNOW);
//
//        Node m1 = m.createNode("samotari", "Samotari", 2000, "MOVIE");
//        Node m2 = m.createNode("medvidek", "Medvidek", 2007, "MOVIE");
//        Node m3 = m.createNode("vratnelahve", "Vratne lahve", 2006, "MOVIE");
//
//        m.createRelationship(m1, a1, MyType.PLAY);
//        m.createRelationship(m1, a2, MyType.PLAY);
//        m.createRelationship(m1, a3, MyType.PLAY);
//        m.createRelationship(m2, a1, MyType.PLAY);
//        m.createRelationship(m3, a4, MyType.PLAY);

//        m.traversal(a1);
//        m.singleQuery();
        m.evaluate();
    }
}

enum MyType implements RelationshipType {
    KNOW, PLAY
}