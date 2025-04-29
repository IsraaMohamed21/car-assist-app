
import query from "../db-connection/connection.js";

function deg2rad(deg) {
    return deg * (Math.PI/180);
}

function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radius of the Earth in kilometers
    const dLat = deg2rad(lat2-lat1);
    const dLon = deg2rad(lon2-lon1);
    const a = 
        Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
        Math.sin(dLon/2) * Math.sin(dLon/2); 
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    const distance = R * c; // Distance in kilometers
    return distance;
}

export const ReqWinch = async (req, res) => {
    const { position, destination, phone } = req.body;

    try {
        // Parse position string into latitude and longitude
        const [latStr, lonStr] = position.split(',').map(str => parseFloat(str));
        const lat1 = latStr || 0; // Default to 0 if parsing fails
        const lon1 = lonStr || 0;

        const destinationQuery = await query("SELECT lat, lon FROM destination WHERE name = ?", [destination]);
        console.log(destinationQuery)
        if (destinationQuery.length === 0) {
            return res.status(400).send("Destination not found");
        }
        const { lat: lat2, lon: lon2 } = destinationQuery[0];
console.log(lat2, lon2  ,destinationQuery[0] )
        // Calculate distance between current location and destination
        const distance = getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2);

        res.status(201).send({ message: "Requested Winch", distance });
    } catch (error) {
        console.error("Error requesting winch:", error);
        res.status(500).send("An error occurred while requesting winch.");
    }
}

export const GetDestinations = async (req,res)=> {
    try {

        const Destinations = await query("SELECT * FROM destination")
      //console.log(Destinations)
        res.status(201).send({Destinations:Destinations});
      } catch (error) {
        console.error("Error Get Destinations:", error);
        res.status(500).send("An error occurred while Get Destinations.");
      }
}

export const GetMechanicsLocations = async (req, res) => {
    try {

        const Locations = await query("SELECT * FROM mechanics_locations")
      //console.log(Destinations)
        res.status(201).send({Locations});
      } catch (error) {
        console.error("Error Get Destinations:", error);
        res.status(500).send("An error occurred while Get Destinations.");
      }

}

export const GetMecName = async (req, res) => {
    const { name } = req.params; // Assuming the ID is provided in the URL parameters

    try {
        const Mec = await query("SELECT * FROM mechanics_locations WHERE Name = ?", [name]);
    console.log(Mec[0],Mec.length )
        if (Mec.length === 0) {
            return res.status(404).json({ error: "Mec not found." });
        }
        res.status(201).send({ MecData: Mec[0] });
    } catch (error) {
        console.error("Error getting mechanics location by Name:", error);
        res.status(500).json({ error: "An error occurred while fetching mechanics location by Name." });
    }
}

export const SendRate = async (req, res) => {
    const { comment , Rate,name } = req.body; // Assuming the ID is provided in the URL parameters
console.log(req.body)
    try {
       
        const result = await query("INSERT INTO rating (Comment, Rate, Name) VALUES (?, ?, ?)", [comment, Rate, name]);

        res.status(201).send({ message: "Rating sent", result });
        
  
    } catch (error) {
        console.error("Error getting SendRate:", error);
        res.status(500).json({ error: "An error occurred while SendRate." });
    }
}