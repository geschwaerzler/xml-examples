package at.fhv.xml.brewrecipes.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

public class Grain {
	
	protected float amount;
	protected Unit unit;
	protected String type;
	protected Integer color;
	
	public Grain() {}

	public Grain(float amount, Unit unit, String type, Integer color) {
		super();
		this.amount = amount;
		this.unit = unit;
		this.type = type;
		this.color = color;
	}
	
	public Grain(float amount, Unit unit, String type) {
		this(amount, unit, type, null);
	}
	
	@JacksonXmlProperty(isAttribute = true)
	public float getAmount() {
		return amount;
	}
	public void setAmount(float value) {
		this.amount = value;
	}

	@JacksonXmlProperty(isAttribute = true)
	public Unit getUnit() {
		return unit;
	}
	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	@JacksonXmlProperty(isAttribute = true)
	public String getType() {
		return type;
	}
	public void setType(String value) {
		this.type = value;
	}

	@JacksonXmlProperty(isAttribute = true)
	@JsonProperty(required = false)
	public Integer getColor() {
		return color;
	}
	public void setColor(Integer value) {
		this.color = value;
	}

}
