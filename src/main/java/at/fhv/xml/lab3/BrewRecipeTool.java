package at.fhv.xml.lab3;

import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;

import at.fhv.xml.lab3.model.Ingredients;
import com.fasterxml.jackson.dataformat.xml.ser.ToXmlGenerator;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;

import at.fhv.xml.lab3.model.BrewRecipe;

/**
 * BrewRecipeTool generates a brew recipe as XML or JSON text.
 * The recipe is hard coded and built as Java object tree in method createRecipe().
 * For Lab3, you should first work in the 'model' package and then
 * change the createRecipe() method, where you build a recipe using the
 * classes from the 'model' package.
 */
public class BrewRecipeTool {

	/**
	 * When running this class, it's static main method will be called.
	 *
	 * @param args String array of the arguments provided with the run command.
	 *             e.g. '-f JSON recipe.json' with yields args == ["-f", "json", "recipe.json"]
	 */
	public static void main(String[] args) {

		// we use the library org.apache.commons.cli in order to handle the arguments
		CommandLineParser cli = new DefaultParser();
		// define option '-h' without argument and option '-f' with an argument
		Options options = new Options();
		options.addOption("f", true, "output recipe in <arg> format. Allowed values 'XML' or 'JSON'");
		options.addOption("h", false, "help");

		try {
			CommandLine cmd = cli.parse(options, args);
			String[] cmdArgs = cmd.getArgs();

			// check, if an optional output filename argument is present
			OutputStreamWriter out;
			if (cmdArgs.length > 1 || cmd.hasOption('h')) {
				// option -h for help or too many arguments are present. Print a usage message.
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp("BrewRecipeTool [-f] [<output file>]", options);
				return;
			} else if (cmdArgs.length == 1) {
				// output the recipe to a file. Filename = the given argument.
				out = new FileWriter(cmd.getArgs()[0]);
			} else {
				// output the recipe to standard out
				out = new OutputStreamWriter(System.out);
			}

			// check, which format shall be produced
			if (cmd.hasOption('f') && cmd.getOptionValue('f').equals("XML")
					|| !cmd.hasOption('f')) //XML is the default, if no -f option is given
			{
				// produce the recipe in XML format
				XmlMapper xml = new XmlMapper();
				xml.configure(ToXmlGenerator.Feature.WRITE_XML_DECLARATION, true);
				xml.enable(SerializationFeature.INDENT_OUTPUT);
				xml.writeValue(out, createRecipe());
			} else if (cmd.hasOption('f') && cmd.getOptionValue('f').equals("JSON")) {
				// produce the recipe in JSON format
				ObjectMapper json = new ObjectMapper();
				json.enable(SerializationFeature.INDENT_OUTPUT);
				json.writeValue(out, createRecipe());
				out.close();
			} else {
				throw new ParseException("allowed values for parameter '-f': 'XML' or 'JSON' ");
			}

		} catch (ParseException e) {
			System.err.println("Parsing options failed: " + e.getMessage());
		} catch (IOException e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * Create a brew recipe as tree of Java objects.
	 * @return the recipe.
	 */
	private static BrewRecipe createRecipe() {
		// create the root element and set its title attribute
		BrewRecipe recipe = new BrewRecipe();
		recipe.setTitle("My Brew Recipe");

		// create an ingredients element with 3 children ...
		Ingredients ingredients = new Ingredients(
				"English 2-row pale ale malt",
				"East Kent Goldings",
				"Wyeast 1084 (Irish Ale)"
		);
		// ... and set it as child of the root element
		recipe.setIngredients(ingredients);

		return recipe;
	}
	
}
