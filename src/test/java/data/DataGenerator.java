package data;

import com.github.javafaker.Faker;

public class DataGenerator {
        public static String getEmail() {

            String email = "noori_idress456";
            int random = (int) (Math.random() * 2145685);
            return email + random + "@gmail.com";
//            Faker faker = new Faker();
//            return faker.name().firstName() + faker.name().lastName() + "@gmail.com";
        }
        public static String getFirstName() {
            char [] alphabet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
            String name = "";
            for (int i=0;i<7;i++){
                int index = (int) (Math.random() * alphabet.length);
                name += alphabet[index];
            }
            return name;
//            Faker faker = new Faker();
//            return faker.name().firstName();
        }
}
