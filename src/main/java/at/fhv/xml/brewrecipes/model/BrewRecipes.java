package at.fhv.xml.brewrecipes.model;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

@JacksonXmlRootElement(localName = "brew-recipes")
public class BrewRecipes {

	protected List<Style> style;
	protected List<Recipe> recipe;

	@JacksonXmlElementWrapper(useWrapping = false)
	public List<Style> getStyle() {
		if (style == null) {
			style = new ArrayList<>();
		}
		return this.style;
	}
	public void setStyle(List<Style> style) {
		this.style = style;
	}

	@JacksonXmlElementWrapper(useWrapping = false)
	public List<Recipe> getRecipe() {
		if (recipe == null) {
			recipe = new ArrayList<>();
		}
		return this.recipe;
	}
	public void setRecipe(List<Recipe> recipe) {
		this.recipe = recipe;
	}

}
