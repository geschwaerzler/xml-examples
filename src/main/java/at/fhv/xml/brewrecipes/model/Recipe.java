package at.fhv.xml.brewrecipes.model;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

@JsonPropertyOrder(value = {"references", "ingredients", "steps"})
public class Recipe {

	protected String name;
	protected String styleId;
	protected List<Reference> references;
	protected Ingredients ingredients;
	protected List<String> steps;

	@JacksonXmlProperty(isAttribute = true)
	public String getName() {
		return name;
	}
	public void setName(String value) {
		this.name = value;
	}

	@JacksonXmlProperty(isAttribute = true, localName = "style-id")
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String value) {
		this.styleId = value;
	}

	@JacksonXmlElementWrapper(useWrapping = false)
	@JsonProperty(value = "reference")
	public List<Reference> getReferences() {
		if (references == null) {
			references = new ArrayList<>();
		}
		return this.references;
	}

	public Ingredients getIngredients() {
		return ingredients;
	}
	public void setIngredients(Ingredients value) {
		this.ingredients = value;
	}

	@JacksonXmlElementWrapper(useWrapping = false)
	@JsonProperty(value = "step")
	public List<String> getSteps() {
		if (steps == null) {
			steps = new ArrayList<>();
		}
		return this.steps;
	}

}
