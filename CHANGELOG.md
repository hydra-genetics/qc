# Changelog

## 0.1.0 (2022-05-09)


### Features

* Add compatibility check ([04b45da](https://www.github.com/hydra-genetics/qc/commit/04b45da457fd1790977e68221206e49b6f537359))
* add conventional-prs workflow ([c94ecab](https://www.github.com/hydra-genetics/qc/commit/c94ecab660e4fb77e498d0f1bf7481f9af5f5ba3))
* Add mosdepth rule and sort smk files in Snakefile ([0fb7de6](https://www.github.com/hydra-genetics/qc/commit/0fb7de6bbbf91aff464b74a6787cf48255046b34))
* Add picard_collect_multiple_metrics ([c8dfc54](https://www.github.com/hydra-genetics/qc/commit/c8dfc542f74a8735ef816e6a5502a4f88e43039a))
* Add picard_collect_wgs_metrics rule ([3cbed9b](https://www.github.com/hydra-genetics/qc/commit/3cbed9bf67bf83cad17b9306eabfb1dbc5fcff6a))
* Add rule picard_collect_gc_bias_metrics ([594fb30](https://www.github.com/hydra-genetics/qc/commit/594fb30decdeb7f7637bc633f18fa64582f4df86))
* added release-please workflow ([5021036](https://www.github.com/hydra-genetics/qc/commit/50210365996ad8dae3abe1013bed335f0fe3cd5c))
* Added rule mosdepth_bed ([6ac5607](https://www.github.com/hydra-genetics/qc/commit/6ac560740582906bfff8f0456cf48b1f91e8475d))
* Added rule mosdepth_bed ([7e2b873](https://www.github.com/hydra-genetics/qc/commit/7e2b873fdeb497c9e08c2368767b9e59ae92d361))
* make compatible with latest snv_indels develop branch ([54bf08e](https://www.github.com/hydra-genetics/qc/commit/54bf08eb37da0ecebbb45227ea07f03863692cba))
* Make region input for hs_metrics optional and rename ([261c0d8](https://www.github.com/hydra-genetics/qc/commit/261c0d801a33106f0c7b3bdfa72ddef25e707054))
* Make wgs_intervals optional for the workflow ([c6ff7cf](https://www.github.com/hydra-genetics/qc/commit/c6ff7cf9664b0af0172fe2ecdb2751f1d0fe3e32))
* New rule: fastqc ([80960a7](https://www.github.com/hydra-genetics/qc/commit/80960a7009f283d9dea49d3d5b12d7753990a323))
* New rule: hotspot_info. Rm unused refs ([e5d80bc](https://www.github.com/hydra-genetics/qc/commit/e5d80bc4f8b749f2ab875edb56275ad04a664782))
* New rule: samtools_stats for general qc using samtools ([f01ad1e](https://www.github.com/hydra-genetics/qc/commit/f01ad1ea5793f9787d6c2f31060a46eac3aab5a7))
* New rules: picard qc stats ([8ad346b](https://www.github.com/hydra-genetics/qc/commit/8ad346b7c31c30efbd906e1a011954b071adc432))
* Print input_list ([80dbcd9](https://www.github.com/hydra-genetics/qc/commit/80dbcd94f2399295940c81c2b3f75552b5db18d9))
* Remove logging function ([33fb902](https://www.github.com/hydra-genetics/qc/commit/33fb90261771a4f86aff4a49c77184f3012eccba))
* Target only final output in compile_output_list ([f55e883](https://www.github.com/hydra-genetics/qc/commit/f55e883814c2dd3bbd45cb386b80a3eb8c772cac))
* Update multiqc input with reads and flowcell ([6642268](https://www.github.com/hydra-genetics/qc/commit/6642268471c1da20f7163b7bb201334d3fdac321))
* Use fastqc wrapper ([8c4e133](https://www.github.com/hydra-genetics/qc/commit/8c4e133e9a29135cb715b3a5641fd72d73c5d6c2))


### Bug Fixes

* Add missing bracket ([8b10a42](https://www.github.com/hydra-genetics/qc/commit/8b10a42b4f9b2ce9dbafb6a4bb3a0f0c8defc34c))
* Add pipe for log file ([dd85f1d](https://www.github.com/hydra-genetics/qc/commit/dd85f1d8ded523cc1268975e7e0b849b229f505a))
* added barcode ([2ff4a3c](https://www.github.com/hydra-genetics/qc/commit/2ff4a3cdc3a044993d146dcdf7543d8a3cd87f23))
* added barcode to fastqc and multiqc ([dfc82a8](https://www.github.com/hydra-genetics/qc/commit/dfc82a83648e51e86d382d6d9f0cb22070e768c7))
* Added default values for memory resources ([4189b81](https://www.github.com/hydra-genetics/qc/commit/4189b81bd8313fd153481ed53d0129c77b50b333))
* added mem_mb to resources schema ([1a05800](https://www.github.com/hydra-genetics/qc/commit/1a05800c6ec1f1b580f80f300db7832926f37c08))
* Added resources, changed container, rm testfiles ([bf25ab5](https://www.github.com/hydra-genetics/qc/commit/bf25ab511311af53cf60aa7f554a0bf2a02503eb))
* change run column name to flowcell in units. ([75f4ec9](https://www.github.com/hydra-genetics/qc/commit/75f4ec90800909306df27a03af5bfd022ea3e9ce))
* changed singularity and config path for bed file ([9d5ba40](https://www.github.com/hydra-genetics/qc/commit/9d5ba40589905eadef5ace7ce8197410927273d2))
* changed singularity and params ([8032ff9](https://www.github.com/hydra-genetics/qc/commit/8032ff91b32f55b4883111a4c0633ce4a5e521be))
* Fix multiqc data dir name ([3e50e26](https://www.github.com/hydra-genetics/qc/commit/3e50e266874fef704b1b6df932ab225841d76cbd))
* good to add the function ([9d119c5](https://www.github.com/hydra-genetics/qc/commit/9d119c5ca1ecce78923cd7fa840590d6db404d9e))
* input that is not required now have default value ([fec20b1](https://www.github.com/hydra-genetics/qc/commit/fec20b178d7d92762b491e2e87be2b48bc44cd7d))
* input that is not required now have default value ([66a481a](https://www.github.com/hydra-genetics/qc/commit/66a481a95d56877f7aebe0acff17e9e8a451371c))
* lock version of mamba and singularity ([6fed76c](https://www.github.com/hydra-genetics/qc/commit/6fed76c260261288ec7ea35f79c5d32d08000e71))
* Missing info in resourse schema ([0213b85](https://www.github.com/hydra-genetics/qc/commit/0213b85907f6f81e01721961fd6a589405db0057))
* Move benchmark output to qc folder ([33245ab](https://www.github.com/hydra-genetics/qc/commit/33245abe52686856b4cfc7c24e5c203cec72f0e5))
* output directory change ([661fefc](https://www.github.com/hydra-genetics/qc/commit/661fefcc77ed4f4823e95b7c898bae21fa55a905))
* rename env file ([74e29f4](https://www.github.com/hydra-genetics/qc/commit/74e29f41bfadeddfbd9b043d8045589005ba81b6))
* resource schema memory had wrong type ([bdb5b4f](https://www.github.com/hydra-genetics/qc/commit/bdb5b4f6564d5349842b621b8f73b73e5fdbcab5))
* singularity path ([b21e5bd](https://www.github.com/hydra-genetics/qc/commit/b21e5bd2ef7615e140241025919e5097d1a4056b))
* sort multiqc output not in alphabetical order! ([0e92f09](https://www.github.com/hydra-genetics/qc/commit/0e92f096da60912a9f3b760010510b06a3fc828a))
* update bam location to match alignment module ([06a39e3](https://www.github.com/hydra-genetics/qc/commit/06a39e3b2aa32acd630d8c6d3e4378009a80c636))
* use curly braces in multiqc ([b4a6ccf](https://www.github.com/hydra-genetics/qc/commit/b4a6ccff79be22c0bf5e7b7bff96b685a1c9d512))
* wrong brackets used ([35f133a](https://www.github.com/hydra-genetics/qc/commit/35f133aafa63beb61de2c4471dbec2cf91f55a47))


### Documentation

* Add rule graph ([80b18a6](https://www.github.com/hydra-genetics/qc/commit/80b18a636f169c9421160c268daa19d212c89ec3))
* added fastp to multiqc qc-files in config.yaml ([48b566a](https://www.github.com/hydra-genetics/qc/commit/48b566a8071b340bcb6d9838e44f4814f086e0f2))
* Complete README ([94b60be](https://www.github.com/hydra-genetics/qc/commit/94b60be965287af4a91186aa375099e1f6f58fa5))
* Update and correct docs ([ea1de9a](https://www.github.com/hydra-genetics/qc/commit/ea1de9a0ec1bd1ddd4fd9568538aefce46faa7a9))
* Update README ([b1f9547](https://www.github.com/hydra-genetics/qc/commit/b1f95478230dd5333c4b794fe2186634f0ee5f29))
