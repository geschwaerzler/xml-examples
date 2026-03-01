package at.fhv.xml.lab3.model;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

/**
 * BrewRecipe represents a single Recipe to brew an ale or beer.
 * This is the starting point For the Lab3
 */
@JacksonXmlRootElement(localName = "brew-recipes")
public class BrewRecipe {

	protected String title;
	protected Ingredients ingredients;
	
	@JacksonXmlProperty(isAttribute = true)
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public Ingredients getIngredients() {
		return ingredients;
	}
	public void setIngredients(Ingredients ingredients) {
		this.ingredients = ingredients;
	}
	
	

}
