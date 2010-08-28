/* Formtastic Validation JS Lib
 * 
 * This library selects form input elements, read the attributes
 * and bind the input field to the corresponding live validation function
 */
var FormtasticValidation = function() {
    this.VERSION = "0.1.0";

    this.selectInputElements = function() {
	var inputElements = document.getElementsByTagName('input');
	var textInputs = new Array;
	for (var i = 0; i < inputElements.length; i++) {
	    var element = inputElements[i];
	    var inputType = element.getAttribute("type");
	    if (this.isValidInputType(inputType)) {
		textInputs.push(inputElements[i]);
	    }
	}
	return textInputs;    
    };

    this.isValidInputType = function(type) {
	switch(type) {
	case "text":
	case "password":
	case "radio":
	case "checkbox":
	    return true;
	default:
	    return false;
	}
    };

    this.getValidationAttributes = function(element) {
	var validationOptions = {};
	var elementAttributes = element.attributes;
	var validationKey, validationValue;
	for(var i = 0; i < elementAttributes.length; i++) {
	    validationKey = this.extractValidationKey(elementAttributes[i].name);
	    validationValue = elementAttributes[i].value;
	    if (validationKey != null) {
		validationOptions[validationKey] = validationValue;
	    }
	}
	return validationOptions;
    };

    this.extractValidationKey = function(key) {
	var namespaceRegex = /validation_(\w+)/;
	var result = key.match(namespaceRegex);
	return result != null ? result[1] : null;
    };
    
    this.extractFormatRegex = function(format) {
	var formatRegex = /^\/(.*)\/$/;
	var result = format.match(formatRegex);
	return result != null ? result[1] : null;
    };

    this.confirmationID = function(element) {
	var elementID = element.getAttribute("id");
	return elementID + "_confirmation";
    };

    this.bindInputElements = function(element, validation, options) {
	var elementValidation = new LiveValidation(element);
	var formatRegex, confirmationElement;
	
	switch(validation) {
	case "validates_acceptance_of":
	    elementValidation.add(Validate.Acceptance, {failureMessage: options["message"]});
	    break;
	case "validates_confirmation_of":
	    confirmationElement = new LiveValidation(this.confirmationID(element));
	    confirmationElement.add(Validate.Confirmation, {match: element, failureMessage: options["message"]});
	    break;
	case "validates_exclusion_of":
	    elementValidation.add(Validate.Exclusion, {within: JSON.parse(options["in"]), allowNull: options["allow_nil"], failureMessage: options["message"]});
	    break;
	case "validates_format_of":
	    formatRegex = this.extractFormatRegex(options["with"]);
	    elementValidation.add(Validate.Format, {pattern: new RegExp(formatRegex), failureMessage: options["message"]});
	    break;
	case "validates_inclusion_of":
	    elementValidation.add(Validate.Inclusion, {within: JSON.parse(options["in"]), allowNull: options["allow_nil"], failureMessage: options["message"]});
	    break;
	case "validates_size_of":
	case "validates_length_of":
	    elementValidation.add(Validate.Length, {is: options["is"], minimum: options["minimum"], maximum: options["maximum"], wrongLengthMessage: options["wrong_length"], tooShortMessage: options["too_short"], tooLongMessage: options["too_long"]});
	    break;
	case "validates_numericality_of":
	    elementValidation.add(Validate.Numericality, {is: options["equal_to"], minimum: options["greater_than_or_equal_to"], maximum: options["less_than_or_equal_to"], onlyinteger: options["only_integer"], failureMessage: options["message"]});
	    break;
	case "validates_presence_of":
	    elementValidation.add(Validate.Presence, {failureMessage: options["message"]});
	    break;
	}
    };
};

FormtasticValidation.prototype.initialize = function() {
    var textInputs = this.selectInputElements();
    var validations, validationTypes, validationOptions;
    for (var i = 0; i < textInputs.length; i++) {
	validations = textInputs[i].getAttribute("validation");
	if (validations != null) {
	    validationTypes = validations.split(" ");
	    for (var j = 0; j < validationTypes.length; j++) {
		validationOptions = this.getValidationAttributes(textInputs[i]);
		this.bindInputElements(textInputs[i], validationTypes[j], validationOptions);
	    }
	}
    }
};