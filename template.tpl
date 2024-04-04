___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GTM Consent State",
  "categories": [
    "UTILITY"
  ],
  "description": "Get the status of each type of Consent Mode implemented in Google Tag Manager.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "selectTarget",
    "radioItems": [
      {
        "value": "all",
        "displayValue": "All types"
      },
      {
        "value": "any",
        "displayValue": "Any type"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "all",
    "help": "Select the name of the Consent Type you want to retrieve.\u003cbr\u003e\nIf you select \"\u003cb\u003eAll types\u003c/b\u003e\", you will get the status of the five types provided by default as an \u003cb\u003eobject\u003c/b\u003e.\u003cbr\u003e\nif you select \u003cb\u003e\"Any type\"\u003c/b\u003e, you will get the value of the type as \u003cb\u003etrue/false\u003c/b\u003e.",
    "displayName": "Get type"
  },
  {
    "type": "SELECT",
    "name": "getType",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "ad_storage",
        "displayValue": "ad_storage"
      },
      {
        "value": "analytics_storage",
        "displayValue": "analytics_storage"
      },
      {
        "value": "functionality_storage",
        "displayValue": "functionality_storage"
      },
      {
        "value": "personalization_storage",
        "displayValue": "personalization_storage"
      },
      {
        "value": "security_storage",
        "displayValue": "security_storage"
      },
      {
        "value": "ad_user_data",
        "displayValue": "ad_user_data"
      },
      {
        "value": "ad_personalization",
        "displayValue": "ad_personalization"
      },
      {
        "value": "custom",
        "displayValue": ""
      }
    ],
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "If you want to get a type that is not provided by default, select the blank box and enter the name of the type you want to get.",
    "defaultValue": "ad_storage",
    "enablingConditions": [
      {
        "paramName": "selectTarget",
        "paramValue": "all",
        "type": "NOT_EQUALS"
      }
    ],
    "displayName": "Type name"
  },
  {
    "type": "TEXT",
    "name": "customName",
    "displayName": "",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "getType",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "notSetText": "[Required value.]"
  },
  {
    "type": "LABEL",
    "name": "customNote",
    "displayName": "\u003cb\u003eNote\u003c/b\u003e: If you want to get a custom type, you need to add the name of the type you want to get to the \u003cb\u003epermissions\u003c/b\u003e of the variable template with read permissions.\u003cbr\u003e\nIf the permission is not set, the value of this variable will be undefined.",
    "enablingConditions": [
      {
        "paramName": "getType",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// -------- setup
// ---- requires
const queryPermission = require('queryPermission');	// check for permissions.
const isConsentGranted = require('isConsentGranted');	// check for consent state.
const copyFromDataLayer = require('copyFromDataLayer');	// check for gtm'event.
const Object = require('Object');	// object's loop processing of object.

// ---- default setting
const consentTypesNames = {
	defaultConsentTypesNames: {
		'ad_storage': 'ad_storage',
		'analytics_storage': 'analytics_storage',
		'functionality_storage': 'functionality_storage',
		'personalization_storage': 'personalization_storage',
		'security_storage': 'security_storage',
		'ad_user_data': 'ad_user_data',
		'ad_personalization': 'ad_personalization'
	},
	customConsentTypeName: {
		'custom': data.customName
	}
};
const nowEvent = copyFromDataLayer('event');

// -------- getting
if(nowEvent !== 'gtm.init_consent'){
	// ---- normal
	switch (data.selectTarget) {
		case 'all':
			const defaultConsentTypesNames = Object.keys(consentTypesNames.defaultConsentTypesNames);
			const canQueryAllDefaultConsentTypes = defaultConsentTypesNames.every((consentType) => {
				return queryPermission('access_consent', consentType, 'read');
			});
			if (canQueryAllDefaultConsentTypes) {
				return defaultConsentTypesNames.reduce((obj, consentType) => {
					obj[consentType] = isConsentGranted(consentType);
					return obj;
				}, {});
			}
			break;
		default:
			const specificConsentType = 
				consentTypesNames.defaultConsentTypesNames[data.getType] ||
				consentTypesNames.customConsentTypeName[data.getType];
			const canQuerySpecificConsentType = queryPermission('access_consent', specificConsentType, 'read');
			if (canQuerySpecificConsentType) {
				return isConsentGranted(specificConsentType);
			}
	}
}else{
	// ---- gtm.init_consent
	return undefined;
}

// -------- error
return false;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: all
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'all'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: ad_storage
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'ad_storage'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: analytics_storage
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'analytics_storage'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: functionality_storage
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'functionality_storage'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: personalization_storage
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'personalization_storage'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: security_storage
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'security_storage'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: ad_personalization
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'ad_personalization'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: ad_user_data
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'ad_user_data'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: custom - testC
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'custom',
      customName: 'testC'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);


___NOTES___

Created on 2021/6/21 12:59:49


