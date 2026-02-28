package at.fhv.xml.brewrecipes.model;

import com.fasterxml.jackson.annotation.JsonValue;

public enum Unit {
	KG("kg"),
	G("g"),
	LB("lb");
	
	String value;
	
	Unit(String value) {
		this.value = value;
	}

	@JsonValue
	public String getValue() {
		return value;
	}

}