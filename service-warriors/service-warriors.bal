import ballerina/http;
import ballerina/log;

//@docker:Expose {}
//@docker:Config {registry: "inaitali/techwatch-ballerina",name: "service-warriors",tag: "1.O.O"}

listener http:Listener warriorsListener = new (8080);

@http:ServiceConfig {basePath: "/api/v1/warriors"}
service warriors on warriorsListener {

    @http:ResourceConfig {methods: ["GET"], path: "/"}
    resource function getAll(http:Caller caller, http:Request req) {

        log:printInfo("Call N° " + increment().toString() + ": Get all warriors");

        if (!req.hasHeader("apikey") || "Z2FtZTpnYW1lMQ==" !== req.getHeader("apikey")) {
            log:printError("Access unauthorized");
            respond(caller, buildMessage(401, "FUNCTIONAL", "err.func.unauthorized", "Access unauthorized"));
        } else if (calsCounter % 4 == 0) {
            // simulating error cases 25% of calls will fail
            log:printError("Error when geting warriors from DB");
            respond(caller, buildMessage(500, "TECHNICAL", "err.tech.get-wirriors", "Error when geting warriors from DB"));
        } else {
            log:printInfo("Succeed to get wirriors, foud 5 items");
            respond(caller, getWarriors());
        }
    }

}

int calsCounter = 0;

function increment() returns int {
    calsCounter = calsCounter + 1;
    return calsCounter;
}

function getWarriors() returns json {
    return [
    {id: 0, name: "Yann_LG", nerfCategory: 8, grade: "*****"},
    {id: 1, name: "Idir_N", nerfCategory: 7, grade: "****"},
    {id: 2, name: "Phillipe_Y", nerfCategory: 8, grade: "**"},
    {id: 3, name: "Lukkas_C", nerfCategory: 6, grade: "****"},
    {id: 4, name: "Fouzi_B", nerfCategory: 6, grade: "****"}
    ];
}

function respond(http:Caller caller, json | http:Response response) {
    var result = caller->respond(response);
    if (result is error) {
        log:printError("Failed to send response: " + result.reason());
    }
}

function buildMessage(int status, string ttype, string code, string message) returns http:Response {
    http:Response httpResponse = new;
    httpResponse.statusCode = status;
    httpResponse.setPayload({errorType: ttype, errorCode: code, errorMessage: message});
    return httpResponse;
}
