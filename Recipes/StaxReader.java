package staxReader;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;

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

	
	static void readCollectionContent(XMLStreamReader r) throws Exception {
		writeKeyValue("description", "TODO: here comes the description", 1);
		moveToEndElem(r, "collection");
	}
		
}
