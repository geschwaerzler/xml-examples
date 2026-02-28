package at.fhv.xml.brewrecipes.model;

import com.fasterxml.jackson.annotation.JsonValue;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlText;

public class Reference {
	
	public static enum Type {
		IMG("img"),
		WWW("www");
		
		String value;
		
		Type(String value) {
			this.value = value;
		}

		@JsonValue
		public String getValue() {
			return value;
		}
	}

	protected Type type;
	protected String value;
	
	public Reference() {}
	
	public Reference(Type type, String value) {
		this.type = type;
		this.value = value;
	}
	@JacksonXmlProperty(isAttribute = true)
	public Type getType() {
		return type;
	}
	public void setType(Type value) {
		this.type = value;
	}

	@JacksonXmlText
	public String getvalue() {
		return value;
	}
	public void setvalue(String value) {
		this.value = value;
	}

}
