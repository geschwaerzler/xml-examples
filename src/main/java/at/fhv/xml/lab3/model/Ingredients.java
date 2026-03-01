package at.fhv.xml.lab3.model;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

@JacksonXmlRootElement(localName = "ingredients")
public class Ingredients {
    String grain;
    String hops;
    String yeast;

    public Ingredients(String grain, String hops, String yeast) {
        this.grain = grain;
        this.hops = hops;
        this.yeast = yeast;
    }

    public String getGrain() {
        return grain;
    }

    public String getHops() {
        return hops;
    }

    public String getYeast() {
        return yeast;
    }
}
