import com.intuit.karate.junit5.Karate;

class KarateBasicTest {

    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate list() {
        return Karate.run("classpath:CharacterList.feature");
    }

    @Karate.Test
    Karate creation() {
        return Karate.run("classpath:CharacterCreation.feature");
    }

    @Karate.Test
    Karate udpate() {
        return Karate.run("classpath:CharacterUpdate.feature");
    }

    @Karate.Test
    Karate delete() {
        return Karate.run("classpath:CharacterDelete.feature");
    }


}
