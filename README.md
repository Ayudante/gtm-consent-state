# GTM Consent State
This is a custom variable template for Google Tag Manager for the web.  
Gets the status of each type of Consent Mode in GTM Syntax as true/false.

## Usage
In the variable to be registered after importing the template, select whether you want to "get all of them together" or "get only one individual agreement type".

### Get All types
Get types: "All types"  
Return value:  
{  
	ad_storage: true/false,  
	analytics_storage: true/false,  
	functional_storage: true/false,  
	personalization_storage: true/false,  
	security_storage: true/false  
}

Gets the five statuses that are provided by default as consent types in GTM in Object format.
The value of each property will be true or false depending on the consent status.

### Get Any type
Get types: "Any type"  
Return value: true/false

Get the status of the selected agreement type as true or false.

**Note**: You can also get the status of custom consent types other than the five default consent types.  
However, in this case, **you need to add the custom consent type you want to retrieve to the access_consent permission of the template with read permission**.

