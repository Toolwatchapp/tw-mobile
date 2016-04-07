//
//  HTTPCode.swift
//  Toolwatch
//
//  Created by math on 2016-04-07.
//  Copyright © 2016 Toolwatch. All rights reserved.
//

import Foundation

/// Declares all the http code we are likely to use. This aligned with 
/// https://github.com/MathieuNls/tw/blob/109_api_endpoints/application/libraries/REST_Controller.php
class HTTPCode{
    
    // Note: Only the widely used HTTP status codes are documented
    // Informational
    internal static var CONTINUE:Int = 100;
    internal static var SWITCHING_PROTOCOLS:Int = 101;
    internal static var PROCESSING:Int = 102;            // RFC2518
    
    // Success
    /**
    * The request has succeeded
    */
    internal static var OK:Int = 200;
    
    /**
    * The server successfully created a new resource
    */
    internal static var CREATED:Int = 201;
    internal static var ACCEPTED:Int = 202;
    internal static var NON_AUTHORITATIVE_INFORMATION:Int = 203;
    
    /**
    * The server successfully processed the request, though no content is returned
    */
    internal static var NO_CONTENT:Int = 204;
    internal static var RESET_CONTENT:Int = 205;
    internal static var PARTIAL_CONTENT:Int = 206;
    internal static var MULTI_STATUS:Int = 207;          // RFC4918
    internal static var ALREADY_REPORTED:Int = 208;      // RFC5842
    internal static var IM_USED:Int = 226;               // RFC3229
    // Redirection
    internal static var MULTIPLE_CHOICES:Int = 300;
    internal static var MOVED_PERMANENTLY:Int = 301;
    internal static var FOUND:Int = 302;
    internal static var SEE_OTHER:Int = 303;
    
    /**
    * The resource has not been modified since the last request
    */
    internal static var NOT_MODIFIED:Int = 304;
    internal static var USE_PROXY:Int = 305;
    internal static var RESERVED:Int = 306;
    internal static var TEMPORARY_REDIRECT:Int = 307;
    internal static var PERMANENTLY_REDIRECT:Int = 308;  // RFC7238
    
    // Client Error
    /**
    * The request cannot be fulfilled due to multiple errors
    */
    internal static var BAD_REQUEST:Int = 400;
    
    /**
    * The user is unauthorized to access the requested resource
    */
    internal static var UNAUTHORIZED:Int = 401;
    internal static var PAYMENT_REQUIRED:Int = 402;
    
    /**
    * The requested resource is unavailable at this present time
    */
    internal static var FORBIDDEN:Int = 403;
    
    /**
    * The requested resource could not be found
    *
    * Note: This is sometimes used to mask if there was an UNAUTHORIZED (401) or
    * FORBIDDEN (403) error, for security reasons
    */
    internal static var NOT_FOUND:Int = 404;
    
    /**
    * The request method is not supported by the following resource
    */
    internal static var METHOD_NOT_ALLOWED:Int = 405;
    
    /**
    * The request was not acceptable
    */
    internal static var NOT_ACCEPTABLE:Int = 406;
    internal static var PROXY_AUTHENTICATION_REQUIRED:Int = 407;
    internal static var REQUEST_TIMEOUT:Int = 408;
    
    /**
    * The request could not be completed due to a conflict with the current state
    * of the resource
    */
    internal static var CONFLICT:Int = 409;
    internal static var GONE:Int = 410;
    internal static var LENGTH_REQUIRED:Int = 411;
    internal static var PRECONDITION_FAILED:Int = 412;
    internal static var REQUEST_ENTITY_TOO_LARGE:Int = 413;
    internal static var REQUEST_URI_TOO_LONG:Int = 414;
    internal static var UNSUPPORTED_MEDIA_TYPE:Int = 415;
    internal static var REQUESTED_RANGE_NOT_SATISFIABLE:Int = 416;
    internal static var EXPECTATION_FAILED:Int = 417;
    internal static var I_AM_A_TEAPOT:Int = 418;                                               // RFC2324
    internal static var UNPROCESSABLE_ENTITY:Int = 422;                                        // RFC4918
    internal static var LOCKED:Int = 423;                                                      // RFC4918
    internal static var FAILED_DEPENDENCY:Int = 424;                                           // RFC4918
    internal static var RESERVED_FOR_WEBDAV_ADVANCED_COLLECTIONS_EXPIRED_PROPOSAL:Int = 425;   // RFC2817
    internal static var UPGRADE_REQUIRED:Int = 426;                                            // RFC2817
    internal static var PRECONDITION_REQUIRED:Int = 428;                                       // RFC6585
    internal static var TOO_MANY_REQUESTS:Int = 429;                                           // RFC6585
    internal static var REQUEST_HEADER_FIELDS_TOO_LARGE:Int = 431;                             // RFC6585
    
    // Server Error
    /**
    * The server encountered an unexpected error
    *
    * Note: This is a generic error message when no specific message
    * is suitable
    */
    internal static var INTERNAL_SERVER_ERROR:Int = 500;
    /**
    * The server does not recognise the request method
    */
    internal static var NOT_IMPLEMENTED:Int = 501;
    internal static var BAD_GATEWAY:Int = 502;
    internal static var SERVICE_UNAVAILABLE:Int = 503;
    internal static var GATEWAY_TIMEOUT:Int = 504;
    internal static var VERSION_NOT_SUPPORTED:Int = 505;
    internal static var VARIANT_ALSO_NEGOTIATES_EXPERIMENTAL:Int = 506;                        // RFC2295
    internal static var INSUFFICIENT_STORAGE:Int = 507;                                        // RFC4918
    internal static var LOOP_DETECTED:Int = 508;                                               // RFC5842
    internal static var NOT_EXTENDED:Int = 510;                                                // RFC2774
    internal static var NETWORK_AUTHENTICATION_REQUIRED:Int = 511;
    
    
}

