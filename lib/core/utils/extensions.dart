extension StringAccentRemovel on String {
  String removeAccents() {
    const withAccents = 'áàâãäåçéèêëíìîïñóòôõöúùûüýÿÁÀÂÃÄÅÇÉÈÊËÍÌÎÏÑÓÒÔÕÖÚÙÛÜÝ';
    const withoutAccents =
        'aaaaaaceeeeiiiinooooouuuuyyAAAAAACEEEEIIIINOOOOOUUUUY';

    String output = this;

    for (int i = 0; i < withAccents.length; i++) {
      output = output.replaceAll(withAccents[i], withoutAccents[i]);
    }

    return output;
  }
}
