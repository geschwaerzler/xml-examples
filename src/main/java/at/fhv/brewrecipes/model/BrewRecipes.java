package at.fhv.brewrecipes.model;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

@JacksonXmlRootElement(localName = "brew-recipes")
public class BrewRecipes {

	protected String attribute;
	protected String child;
	
	@JacksonXmlProperty(isAttribute = true)
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	
	public String getChild() {
		return child;
	}
	public void setChild(String child) {
		this.child = child;
	}
	
	

}
