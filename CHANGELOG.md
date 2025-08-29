# Changelog

## [0.6.0](https://www.github.com/hydra-genetics/qc/compare/v0.5.0...v0.6.0) (2025-08-29)


### Features

* add '-' to barcode wildcard constraint ([f6fb93e](https://www.github.com/hydra-genetics/qc/commit/f6fb93e0a49e02aa310b5fc54d68df743eed8dce))
* add bcftools stats ([8020bae](https://www.github.com/hydra-genetics/qc/commit/8020bae8c10edb6680e2813d7ad16e6d144ca337))
* add cramino and nanoplot ([5a30c6a](https://www.github.com/hydra-genetics/qc/commit/5a30c6aaef73f4c5f0e140b250931030f617125e))
* add multiqc rule for long-read input ([9833a37](https://www.github.com/hydra-genetics/qc/commit/9833a376710858ee09a2388df28c673a641f8ab8))
* add sequali ([babe3ba](https://www.github.com/hydra-genetics/qc/commit/babe3ba93a4b4f93021e7c9db6620bf57bfb6e45))


### Bug Fixes

* change to correct container path for nanoplot ([ce47aa8](https://www.github.com/hydra-genetics/qc/commit/ce47aa83f703a63feca353c89a069a9f2a4e7894))
* **nanoplot:** fix output directory and temp outputs ([ee34e36](https://www.github.com/hydra-genetics/qc/commit/ee34e368a42bf3a9d2214ed16f28e1134d5808f3))
* **nanoplot:** fix typo in command name ([14e3da4](https://www.github.com/hydra-genetics/qc/commit/14e3da497e1ddb4eb34b11c9721ee3694baa2a0f))
* **nanoplot:** switch to bam input for multiqc compatability ([230941f](https://www.github.com/hydra-genetics/qc/commit/230941fc598f494c5360e3f5490431475d85780a))
* **picard:** add missing extra to collect duplicate metrics rule ([0e3bff4](https://www.github.com/hydra-genetics/qc/commit/0e3bff48c39edb44803855a7e69d5a2b3fe255b3))
* **samtools_idxstats:** point to correct config ([0737673](https://www.github.com/hydra-genetics/qc/commit/0737673647f20a36c1c96a2968700fcdc45ea9ff))

## [0.5.0](https://www.github.com/hydra-genetics/qc/compare/v0.4.1...v0.5.0) (2024-04-18)


### Features

* add vertifybamid2 ([c604d05](https://www.github.com/hydra-genetics/qc/commit/c604d05a50f35d286440ed192970ebc90f31fba6))
* update samtools.smk and remove design_bed as a default extra ([#112](https://www.github.com/hydra-genetics/qc/issues/112)) ([da66130](https://www.github.com/hydra-genetics/qc/commit/da661302b6297fa36962e4b2b5a7874da4773fe0))
* update snakemake version, allow range up to version 8 ([8a18038](https://www.github.com/hydra-genetics/qc/commit/8a1803860b99d4aa446cd126b326877bb3e6a12b))


### Bug Fixes

* add bai file to picard rules that needs it ([dbc71e7](https://www.github.com/hydra-genetics/qc/commit/dbc71e7e258aacaa39902a603c7ae9bbdac6c19c))
* excluded verifybamid from integration testing ([03ab7f7](https://www.github.com/hydra-genetics/qc/commit/03ab7f72060cf596cc683058c2478cfd340ee622))
* Update requirements.txt ([#114](https://www.github.com/hydra-genetics/qc/issues/114)) ([c882232](https://www.github.com/hydra-genetics/qc/commit/c8822321c8c695284d7f421c4824c40d72aca34a))
* Update to make outputs temporary ([5045af4](https://www.github.com/hydra-genetics/qc/commit/5045af47f2ec9fee2dd7adff26ccc9d0104b6c5f))


### Documentation

* add files to build rtd and test the build ([#117](https://www.github.com/hydra-genetics/qc/issues/117)) ([47ebeac](https://www.github.com/hydra-genetics/qc/commit/47ebeac49ec08efc2816c0c525a4ef136973cee4))
* added rtd for all rules up to picard ([f4bc663](https://www.github.com/hydra-genetics/qc/commit/f4bc6636d99df461a2c4ea791840365e990a8a69))
* update plugin version and added override value for multiqc input ([d6a06c6](https://www.github.com/hydra-genetics/qc/commit/d6a06c685b04a72d2d7c0a375fd6d795832b3549))
* update rule graph ([#116](https://www.github.com/hydra-genetics/qc/issues/116)) ([3470422](https://www.github.com/hydra-genetics/qc/commit/34704224af1efe4e936dea73362cf28b9bf00644))
* Update softwares.md ([75ad68f](https://www.github.com/hydra-genetics/qc/commit/75ad68fe90dd310fac66d028cc25ea6bbb7a35f3))
* Updated rules.schema.yaml with additional details on inputs and outputs ([d3780c4](https://www.github.com/hydra-genetics/qc/commit/d3780c4b898c45c06bbb7b2c6a678db2ffb26535))

### [0.4.1](https://www.github.com/hydra-genetics/qc/compare/v0.4.0...v0.4.1) (2023-05-05)


### Bug Fixes

* remove conda from picard.smk ([#102](https://www.github.com/hydra-genetics/qc/issues/102)) ([31eb95f](https://www.github.com/hydra-genetics/qc/commit/31eb95f8210341c7239ebffab7492c4fdc464673))

## [0.4.0](https://www.github.com/hydra-genetics/qc/compare/v0.3.0...v0.4.0) (2023-04-14)


### Features

* drop conda support and testing ([2e962a3](https://www.github.com/hydra-genetics/qc/commit/2e962a3873a3cfeb2dc63ea69bb4f5907ecd9aa6))


### Documentation

* update compatibility ([4dad537](https://www.github.com/hydra-genetics/qc/commit/4dad537e9e2669d46746ebfebf1febb9a13faf39))
* update compatibility ([501a5a8](https://www.github.com/hydra-genetics/qc/commit/501a5a8f8fc83a0d07ab7007e21dd458dacadbab))

## [0.3.0](https://www.github.com/hydra-genetics/qc/compare/v0.2.0...v0.3.0) (2023-01-26)


### Features

* **peddy:** add vcf tbi to inputs ([#87](https://www.github.com/hydra-genetics/qc/issues/87)) ([68b30bf](https://www.github.com/hydra-genetics/qc/commit/68b30bf99b740b822f8d052492b2c1f3e6807c4b))


### Bug Fixes

* compatibility fix for fastp in prealignment v1.0.0 ([e4e0b1a](https://www.github.com/hydra-genetics/qc/commit/e4e0b1a5b1f704d4b8b18a9073399ef1876ab14e))
* multiqc should take input files as default ([e51457d](https://www.github.com/hydra-genetics/qc/commit/e51457de534efdf778ca17b9d73826eef538c2f8))


### Documentation

* update version list in compatibility file ([544ef48](https://www.github.com/hydra-genetics/qc/commit/544ef48898d6ffb4f686b5d6785f7f029ef9f5d8))

## [0.2.0](https://www.github.com/hydra-genetics/qc/compare/v0.1.0...v0.2.0) (2022-11-09)


### Features

* Add peddy rule ([#79](https://www.github.com/hydra-genetics/qc/issues/79)) ([cf4843a](https://www.github.com/hydra-genetics/qc/commit/cf4843a21b2e5fb9bc36718891c325ee2336323d))
* Add rseqc and make multiqc take specific type ([9f9db81](https://www.github.com/hydra-genetics/qc/commit/9f9db815b9d43da15dc8089f36f6cb2ccc8b582a))
* **ci:** pull-request template ([9cabf8d](https://www.github.com/hydra-genetics/qc/commit/9cabf8d22f243b010caaa2ad71e6996a7fa3c0a8))
* **common:** added gatk_get_pileup_summaries output file ([c14ae28](https://www.github.com/hydra-genetics/qc/commit/c14ae28e9277610be28cc2353f2f736a76942a85))
* **common:** added output file for gatk_calculate_contamination ([ddff81c](https://www.github.com/hydra-genetics/qc/commit/ddff81c4c52d512cf3f396f6b0a1e91d6844ec8a))
* **config:** added configs for gatk_calculate_contamination ([3a77442](https://www.github.com/hydra-genetics/qc/commit/3a774424fcc69d9402d5c5890d119ddf2f7cc284))
* **config:** added gatk_get_pileup_summaries to configs ([68f9fe9](https://www.github.com/hydra-genetics/qc/commit/68f9fe9924f8a1f0be85534cfc2880eddbb97766))
* **config:** added input file to config ([5923ff9](https://www.github.com/hydra-genetics/qc/commit/5923ff9c9c2fc7cf6d3f961f2d34279665fd9190))
* convert list to set ([69e5fed](https://www.github.com/hydra-genetics/qc/commit/69e5fedc67d1aa551e868c5b0a6379e36d482306))
* **env:** added gatk_get_pileup_summaries env ([f08ab11](https://www.github.com/hydra-genetics/qc/commit/f08ab11e1b57ddc3423a5fe35436fccb0e491de7))
* extra parameter depending on report type ([a41b1b6](https://www.github.com/hydra-genetics/qc/commit/a41b1b6dc57fb9d2b72eaff312b8fe49c8fbbd6b))
* make config.yaml location more flexible ([36e1969](https://www.github.com/hydra-genetics/qc/commit/36e196903e7b33941ad1f2c0e554ddb507cc775f))
* make configfile/confgilefiles argument mandatory ([f26c509](https://www.github.com/hydra-genetics/qc/commit/f26c509b8d22788b611282eab367fab94e05fcda))
* make it possible to generate multiple multiqc reports using the same rule. ([cbd63ec](https://www.github.com/hydra-genetics/qc/commit/cbd63ec1128f0962afc431b8074ede3b63b2a304))
* **rule:** adapted contamination output file to multiQC format ([d264e00](https://www.github.com/hydra-genetics/qc/commit/d264e005c563f32699b4a0e02fc65068c7eaadbc))
* **rule:** added gatk_get_pileup_summaries rule ([d484e71](https://www.github.com/hydra-genetics/qc/commit/d484e71aaa18a1a1c3577e592dc20bbfce38a44a))
* **rule:** added rule and updated test set ([1756fa5](https://www.github.com/hydra-genetics/qc/commit/1756fa50c0bffb4f28ba9d601088876370606250))
* **schema:** added gatk_get_pileup_summaries schemas ([e1c44af](https://www.github.com/hydra-genetics/qc/commit/e1c44afeb65701249e92a7bb3cd19a07d6776412))
* **schema:** added schemas for gatk_calculate_contamination ([9e80863](https://www.github.com/hydra-genetics/qc/commit/9e8086303f5d8749a60fe6fc1a54a87c9a357985))
* **Snakefile:** added gatk to Snakefile ([f30e6c6](https://www.github.com/hydra-genetics/qc/commit/f30e6c68775090e6a7f758c3249d0f63ffb9e7ad))
* start using multiqc-wrapper ([aa027ea](https://www.github.com/hydra-genetics/qc/commit/aa027eac8a5bdb1b0de741d9d6757f2628625352))
* Update samtools.smk ([265deab](https://www.github.com/hydra-genetics/qc/commit/265deab15b8aad1684f15fe610cbb0359ea82588))
* update snakemake-version ([03a7171](https://www.github.com/hydra-genetics/qc/commit/03a7171dae7297044973423cd84ae090a551c80e))


### Bug Fixes

* access config with get and set defaults ([8e0d327](https://www.github.com/hydra-genetics/qc/commit/8e0d32709acdd83c075c6cac621e59b9f9d1e35b))
* added bai as input as it is required ([c8b13a1](https://www.github.com/hydra-genetics/qc/commit/c8b13a1ed0e7e1d920d0a24f84d3fa1325f8dc61))
* added tabulate<0.9.0 requirement ([ffc0d6a](https://www.github.com/hydra-genetics/qc/commit/ffc0d6a7c38a3996cc5de8dc02ad57828c26586d))
* change multiqc to use shell until modification to the wrapper have been approved ([3ab568e](https://www.github.com/hydra-genetics/qc/commit/3ab568e6c3d8be48f8a94abebe8055addb4fe8c9))
* fastqc input name to multiqc ([bbc8eda](https://www.github.com/hydra-genetics/qc/commit/bbc8eda18d7820fd8037b349a98beca5c90a187b))
* handle config file for multiqc correctly ([1d12776](https://www.github.com/hydra-genetics/qc/commit/1d12776088207f9b8f34ee6998c3538119f5c186))
* **multiqc:** log files and benchmarks renamed so that are not picked up by multiqc ([eb9f33b](https://www.github.com/hydra-genetics/qc/commit/eb9f33b9b3b3f7f0367d05ae1dfb1cbc1cb23d30))
* outputfiles without tsv ending ([e356c9f](https://www.github.com/hydra-genetics/qc/commit/e356c9f19cc5f3178c838cbe81d13be1453f0c05))
* rm mgc tag on files ([67c97a4](https://www.github.com/hydra-genetics/qc/commit/67c97a42c10bbaffda56c579eb6a09ac4f08c867))
* rm mgc tag on files ([b767fdf](https://www.github.com/hydra-genetics/qc/commit/b767fdf2a8567b6bee32e6cfc930cf7ea9bcfc17))
* spelling error ([eb6460a](https://www.github.com/hydra-genetics/qc/commit/eb6460a72da23b88be0dda119809bbeee9f84eaf))
* **test:** update with bam file that will be able to run rseqc ([d449d7b](https://www.github.com/hydra-genetics/qc/commit/d449d7b605254039e7967717ce3ef3dcdbb11237))
* updated compatibilty config ([cd2e5df](https://www.github.com/hydra-genetics/qc/commit/cd2e5df9ffe74234aa2473c4905c24ca2b79f710))


### Documentation

* **redme:** update logo ([82c7911](https://www.github.com/hydra-genetics/qc/commit/82c79118fcf1bdfe1bf0df5f9955d09c50353586))
* remove pytest and pycodestyle badges ([ff85877](https://www.github.com/hydra-genetics/qc/commit/ff85877c5f3b1046ea662307681eb324257bd7e7))
* update readme ([d735726](https://www.github.com/hydra-genetics/qc/commit/d7357267720c035ccfab353fa87d77a97c2f4e03))
* updated documentation ([b11e279](https://www.github.com/hydra-genetics/qc/commit/b11e2799ae4c27a235b4fe30712982d033969174))

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
