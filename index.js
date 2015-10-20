function CoffeeScriptSyntax() {
  return {
    build: function build (functionName, pattern, parameters, comment) {
      var callbackName = parameters[parameters.length - 1];
      var snippet =
        '@' + functionName + ' ' + pattern + ', (' + parameters.join(', ') + ') -> ' + '\n' +
        '  # ' + comment + '\n' +
        '  ' + callbackName + '.pending()' + '\n' +
        '\n';
      return snippet;
    }
  };
}

module.exports = CoffeeScriptSyntax;
