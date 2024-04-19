package staxReader;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.util.List;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

public class StaxReader {
	static FileWriter output;
	static String delimiter;

	public static void main(String[] args) {
		Reader input;
		try {
			input = new FileReader("recipes.xml");
			output = new FileWriter("recipes.json");
			XMLInputFactory f = XMLInputFactory.newInstance();
			XMLStreamReader r = f.createXMLStreamReader(input);
			
			//skip everything until the start of the root element
			moveToStartElem(r);
			
			if (! r.getLocalName().equals("collection")) {
				throw new Exception("Recipes should have a <collection> root element.");
			}
			
			delimiter = "{\n";
			readCollectionContent(r);
			output.write("}\n");
			
			output.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (XMLStreamException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}

	}
	
	/*  helpers */
	
	static void moveToStartElem(XMLStreamReader r) throws XMLStreamException {
		//skip everything until the start of a new element
		while(r.next() != XMLStreamReader.START_ELEMENT) {}		
	}
	
	static void moveToEndElem(XMLStreamReader r, String elemName) throws XMLStreamException {
		//skip everything until an end tag of elemName
		do {
			//skip for the next end element
			while(r.next() != XMLStreamReader.END_ELEMENT) {}
		} while (!r.getLocalName().equals(elemName));
		//read next tag
		r.nextTag();
	}
	
	
	static void readCollectionContent(XMLStreamReader r) throws Exception {
		r.nextTag();
		
		if (! r.getLocalName().equals("description")) {
			throw new Exception("<collection> elements must have a <description>.");
		}
		writeKeyValue("description", r.getElementText(), 1);
		delimiter = ",\n";

		r.nextTag();
		writeQuotedString("author", 0);
		delimiter = " : [";
		while (r.getLocalName().equals("author")) {
			writeQuotedString(r.getElementText(), 0);
			delimiter = ",";
			r.nextTag();
		}
		delimiter = "],\n";
		
		writeQuotedString("recipes", 1);
		output.write(" : [\n");
		while (r.getLocalName().equals("recipe")) {
			readRecipeContent(r);
		}
		output.write("\t]\n");
	}
	
	static void readRecipeContent(XMLStreamReader r) throws Exception {
		delimiter = "\t{\n";

		r.nextTag();
		if (! r.getLocalName().equals("title")) {
			throw new Exception("<recipe> elements must have a <title>.");
		}
		writeKeyValue("title", r.getElementText(), 2);
		delimiter = "},\n";
		
		//skip the rest
		moveToEndElem(r, "recipe");
		output.write("\t},");
	}
	
	static void writeQuotedString(String s, int indent) throws IOException {
		if (delimiter != null && delimiter.length() > 0) {			
			output.write(delimiter);
			delimiter = null;
		}
		for (int i = indent; i > 0; i--) {
			output.write('\t');
		}		
		output.write('"');
		output.write(s);
		output.write('"');
	}
		
	static void writeKeyValue(String key, String value, int indent) throws IOException {
		writeQuotedString(key, indent);
		delimiter = " : ";
		writeQuotedString(value.trim(), 0);
	}

	static void writeKeyValue(String key, List<String> values, int indent) throws IOException {
		writeQuotedString(key, indent);
		output.write(" : [");

		if (!values.isEmpty()) {
			int i = 0;
			writeQuotedString(values.get(i++), 0);
			while (i < values.size()) {
				output.write(',');
				writeQuotedString(values.get(i++), 0);
			}
		}
		output.write("[\n");
	}
}
