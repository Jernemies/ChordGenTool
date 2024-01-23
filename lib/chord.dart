class Chord {

  	int? root;
		List<int>? tones;
		String? name;
    List<String>? extensions;

		Chord(int root, List<int> tones, String name, List<String> extensions){
			this.root = root;
			this.tones = tones;
			this.name = name;
      this.extensions = extensions;
		}

}