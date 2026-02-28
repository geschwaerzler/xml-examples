package at.fhv.xml.brewrecipes.model;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;

public class Ingredients {

	protected List<Grain> grain;
	protected List<Hops> hops;
	protected String yeast;

	@JacksonXmlElementWrapper(useWrapping = false)
	public List<Grain> getGrain() {
		if (grain == null) {
			grain = new ArrayList<>();
		}
		return this.grain;
	}

	@JacksonXmlElementWrapper(useWrapping = false)
	public List<Hops> getHops() {
		if (hops == null) {
			hops = new ArrayList<>();
		}
		return this.hops;
	}

	public String getYeast() {
		return yeast;
	}
	public void setYeast(String value) {
		this.yeast = value;
	}

}
