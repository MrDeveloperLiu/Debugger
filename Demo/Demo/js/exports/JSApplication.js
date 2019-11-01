function application () {
    
    this.token = null;
    this.information = { id: 'id_0001', name: 'little-app' };
    
    
    this.applicationDidFinishedLauchedWithOptions = function(options) {
        token = options['token']
        console.log('applicationDidFinishedLauchedWithOptions options:' + token);
    };
    
    this.applicationDidEnterBackground = function() {
        console.log('applicationDidEnterBackground');
    };
    
    this.applicationDidEnterForeground = function() {
        console.log('applicationDidEnterForeground');
    };
    
    this.applicationWillTerminate = function() {
        console.log('applicationWillTerminate');
    };
    
    this.applicationDidStop = function() {
        console.log('applicationDidStop');
    };
};

var application = new application();

