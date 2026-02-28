package at.fhv.xml.brewrecipes.model;

import com.fasterxml.jackson.annotation.JsonValue;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

public class Style {
	
	public static enum Family {
		ALE("ale"),
		LAGER("lager"),
		HYBRID("hybrid");
		
		String value;
		
		Family(String value) {
			this.value = value;
		}

		@JsonValue
		public String getValue() {
			return value;
		}
	}

	protected String id;
	protected String name;
	protected Family family;
	
	public Style() {}
	
	public Style(String id, String name, Family family) {
		this.id = id;
		this.name = name;
		this.family = family;
	}

	@JacksonXmlProperty(isAttribute = true)
	public String getId() {
		return id;
	}
	public void setId(String value) {
		this.id = value;
	}

	@JacksonXmlProperty(isAttribute = true)
	public String getName() {
		return name;
	}
	public void setName(String value) {
		this.name = value;
	}

	@JacksonXmlProperty(isAttribute = true)
	public Family getFamily() {
		return family;
	}
	public void setFamily(Family value) {
		this.family = value;
	}

}
