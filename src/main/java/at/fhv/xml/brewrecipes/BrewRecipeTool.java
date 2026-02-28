package at.fhv.xml.brewrecipes;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.List;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;

import at.fhv.xml.brewrecipes.model.BrewRecipes;
import at.fhv.xml.brewrecipes.model.Grain;
import at.fhv.xml.brewrecipes.model.Hops;
import at.fhv.xml.brewrecipes.model.Ingredients;
import at.fhv.xml.brewrecipes.model.Recipe;
import at.fhv.xml.brewrecipes.model.Reference;
import at.fhv.xml.brewrecipes.model.Reference.Type;
import at.fhv.xml.brewrecipes.model.Style;
import at.fhv.xml.brewrecipes.model.Style.Family;
import at.fhv.xml.brewrecipes.model.Unit;

public class BrewRecipeTool {

	public static void main(String[] args) {

		CommandLineParser cli = new DefaultParser();
		Options options = new Options();
		options.addOption("t", true, "type of format: json | xml (default)");
		options.addOption("o", true, "output file in XMKL or JSON format");
		
		try {
			BrewRecipes recipes = null;
			
			CommandLine cmd = cli.parse(options, args);
			XmlMapper xml = new XmlMapper();
			
			if (cmd.getArgs().length == 1) {
				String inPath = cmd.getArgs()[0];
				recipes = xml.readValue(new File(inPath), BrewRecipes.class);
			} else if (cmd.getArgs().length == 0) {
				recipes = new BrewRecipes();
				recipes.getStyle().add(new Style("koelsch", "Kölsch", Family.HYBRID));
			} else {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp("BrewRecipe [-t <type>] [-o <file>] <file>", options);
				return;
			}
			
			recipes.getRecipe().add(getKoelsch());

			OutputStreamWriter out = new OutputStreamWriter(System.out);
			if (cmd.hasOption('o')) {
				out = new FileWriter(cmd.getOptionValue('o'));
			}

			if (cmd.hasOption('t')) {
				if (cmd.getOptionValue('t').equals("xml")) {
					xml.enable(SerializationFeature.INDENT_OUTPUT);
					xml.writeValue(out, recipes);					
				} else if (cmd.getOptionValue('t').equals("json")) {
					ObjectMapper json = new ObjectMapper();
					json.enable(SerializationFeature.INDENT_OUTPUT);
					json.writeValue(out, recipes);					
				} else {
					System.err.println("allowed values for option t: 'xml' or 'json'");					
				}
			}
			
			out.close();
		} catch (ParseException e) {
			System.err.println("Parsing options failed: " + e.getMessage());
		} catch (IOException e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	private static Recipe getKoelsch() {
		Recipe recipe = new Recipe();
		recipe.setName("Kölsch");
		recipe.setStyleId("koelsch");
		
		recipe.getReferences().add(new Reference(Type.IMG, "img/koelsch.gng"));
		
		Ingredients ingredients= new Ingredients();
		recipe.setIngredients(ingredients);
		
		List<Grain> grains = ingredients.getGrain();
		grains.add(new Grain(2.0f, Unit.KG, "Kölsch malt", 4));
		grains.add(new Grain(1.86f, Unit.KG, "Pilsner malt"));
		grains.add(new Grain(200.0f, Unit.G, "pale wheat malt"));
		grains.add(new Grain(90.0f, Unit.G, "Carapils®/Carafoam® malt"));
		
		List<Hops> hops = ingredients.getHops();
		hops.add(new Hops(31, Unit.G, 4, 60, "Tettnanger"));
		hops.add(new Hops(31, Unit.G, 4, 10, "Tettnanger"));
		
		ingredients.setYeast("Wyeast 2565 (Kölsch)");
		
		List<String> steps = recipe.getSteps();
		steps.add("This recipe uses a multi-step infusion mash. Dough in at around 104 °F (40 °C) for a hydration rest of 15 minutes.");
		steps.add("Raise the temperature to 122 °F (50 °C) for a protein rest of 15 minutes.");
		steps.add("Raise the temperature to 149 °F (65 °C) for a beta amylase rest of 30 minutes.");
		steps.add("Raise the temperature to 162 °F (72 °C) for an alpha amylase rest of 30 minutes.");
		steps.add("Raise temperature to 169 °F (76 °C) for the mash-out.");
		steps.add("Recirculate wort then begin sparge.");
		steps.add("Boil for 75 minutes, adding hops as indicated.");
		steps.add("At the end of the boil, turn off heat and whirlpool for 15 minutes.");
		steps.add("Heat-exchange to the high end of the temperature range for the selected yeast.");
		steps.add("As soon as primary fermentation is vigorous, reduce the tank temperature to the low end of the yeast’s temperature range.");
		steps.add("After 7 additional days, give the beer a diacetyl rest by raising the tank temperature to 66 °F (19 °C) and hold it there for about 2 days.");
		steps.add("Rack and reduce the beer temperature for lagering by 2 °F (1 °C ) a day until reaching 31 °F (–1 °C) or close to it, equipment permitting.");
		steps.add("The lagering temperature should definitely not be higher than 38 °F (3.5 °C).");
		steps.add("Lager for 4 to 6 weeks. Some brewers may shorten the lagering time to 2 to 4 weeks, others will lengthen it to 12 weeks.");
		steps.add("Rack again.");
		steps.add("Carbonate to 2.55 to 3 volumes of CO2.");
		
		return recipe;
	}

}