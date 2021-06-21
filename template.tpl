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
  "categories": ["UTILITY"],
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
        "value": "ad",
        "displayValue": "ad_storage"
      },
      {
        "value": "analytics",
        "displayValue": "analytics_storage"
      },
      {
        "value": "functional",
        "displayValue": "functional_storage"
      },
      {
        "value": "personalization",
        "displayValue": "personalization_storage"
      },
      {
        "value": "security",
        "displayValue": "security_storage"
      },
      {
        "value": "custom",
        "displayValue": ""
      }
    ],
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "If you want to get a type that is not provided by default, select the blank box and enter the name of the type you want to get.",
    "defaultValue": "ad",
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

// 初期設定
const queryPermission = require('queryPermission');
const isConsentGranted = require('isConsentGranted');
const getTypeName = {
	'ad': 'ad_storage',
	'analytics': 'analytics_storage',
	'functional': 'functional_storage',
	'personalization': 'personalization_storage',
	'security': 'security_storage',
	'custom': data.customName
};

// 取得処理
switch(data.selectTarget){
	case 'all':
		if(queryPermission('access_consent', 'ad_storage', 'read') && queryPermission('access_consent', 'analytics_storage', 'read') && queryPermission('access_consent', 'functional_storage', 'read') && queryPermission('access_consent', 'personalization_storage', 'read') && queryPermission('access_consent', 'security_storage', 'read')){
			return {
				ad_storage: isConsentGranted('ad_storage'),
				analytics_storage: isConsentGranted('analytics_storage'),
				functional_storage: isConsentGranted('functional_storage'),
				personalization_storage: isConsentGranted('personalization_storage'),
				security_storage: isConsentGranted('security_storage')
			};
		}
		break;
	default:
		if(queryPermission('access_consent', getTypeName[data.getType], 'read')) return isConsentGranted(getTypeName[data.getType]);
}

// 例外処理
return undefined;


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
                    "string": "functional_storage"
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
- name: ad
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'ad'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: analytics
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'analytics'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: functional
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'functional'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: personalization
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'personalization'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: security
  code: |-
    const mockData = {
      // Mocked field values
      selectTarget: 'any',
      getType: 'security'
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


