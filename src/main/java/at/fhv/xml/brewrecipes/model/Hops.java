package at.fhv.xml.brewrecipes.model;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlText;

public class Hops {

	protected float amount;
	protected Unit unit;
	protected float alpha;
	protected int minutesBeforeBoilEnd;
	protected String description;
	
	public Hops() {}

	public Hops(float amount, Unit unit, float alpha, int minutesBeforeBoilEnd, String description) {
		super();
		this.amount = amount;
		this.unit = unit;
		this.alpha = alpha;
		this.minutesBeforeBoilEnd = minutesBeforeBoilEnd;
		this.description = description;
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
	public float getAlpha() {
		return alpha;
	}
	public void setAlpha(float value) {
		this.alpha = value;
	}

	@JacksonXmlProperty(isAttribute = true, localName = "minutes-before-boil-end")
	public int getMinutesBeforeBoilEnd() {
		return minutesBeforeBoilEnd;
	}
	public void setMinutesBeforeBoilEnd(int value) {
		this.minutesBeforeBoilEnd = value;
	}

	@JacksonXmlText
	public String getDescription() {
		return description;
	}
	public void setDescription(String value) {
		this.description = value;
	}

}
