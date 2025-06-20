import com.intuit.karate.junit5.Karate;

class KarateBasicTest {

    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate list() {
        return Karate.run("src/test/java/com/pichincha/features/bp_dev_test");
    }


}
