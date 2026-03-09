# Changelog

## [0.7.0](https://github.com/hydra-genetics/qc/compare/v0.6.0...v0.7.0) (2026-03-09)


### Features

* add sample match validation script and test script ([5802a3d](https://github.com/hydra-genetics/qc/commit/5802a3d893299373de02ff69dd30d33a4d3a3f26))
* add somalier extract wrapper ([f061926](https://github.com/hydra-genetics/qc/commit/f0619266b5b5fa23eaa08cd15c18b44bf9c39480))
* add somalier for matched (grouped) samples ([d0a6dbe](https://github.com/hydra-genetics/qc/commit/d0a6dbe38e342825db3e445f305b10e03cb9937a))
* add somalier for sex and relatedness checks ([0dd8ec9](https://github.com/hydra-genetics/qc/commit/0dd8ec9a016214989432ac0cba9bf5137aab893a))
* add somalier for trios ([c69e552](https://github.com/hydra-genetics/qc/commit/c69e552cad7fb57fb503deb67080f2e7bc901829))
* add somalier python unit testing ([18bf72b](https://github.com/hydra-genetics/qc/commit/18bf72bcfbcf693359a9a2c1c164de3a3a6e39f7))
* add somalier sites reference files ([d0e8b94](https://github.com/hydra-genetics/qc/commit/d0e8b941ee936591612e14bdbd08e76a0f21ea03))
* add somalier test files ([7b0872f](https://github.com/hydra-genetics/qc/commit/7b0872f52921c456c6ba5fd0fa0a71126bc582c1))
* add somalier trio ([bf6292d](https://github.com/hydra-genetics/qc/commit/bf6292de758e2ec65b1234610e588b8f6980d312))
* add somalier trio configuration ([0520f37](https://github.com/hydra-genetics/qc/commit/0520f37fa76ed6765af5e9f6c82c66311b1eb119))
* add somalier ungrouped ([104d4f2](https://github.com/hydra-genetics/qc/commit/104d4f25f6e3bbe43a741499640c097826c1d56f))
* add somalier ungrouped for relatedness check ([99c5767](https://github.com/hydra-genetics/qc/commit/99c576795bc3ed6b2d48dcfa05ae36b5bcf1ba80))
* add test sheets for trio-based sample testing ([6d046a5](https://github.com/hydra-genetics/qc/commit/6d046a5b5b0fe59090dd233709c96c2434afe1e8))
* added fgbio qc summuray rule for MultiQC ([0485aa3](https://github.com/hydra-genetics/qc/commit/0485aa361b98599e32e3ff5317a777e6b58c5fbf))
* added fgbio_collect_duplex_seq_metrics ([773bbf6](https://github.com/hydra-genetics/qc/commit/773bbf6c2702f3d1f6600c79c320b9b79ca0fa23))
* added fgbio_collect_duplex_seq_metrics ([7634a50](https://github.com/hydra-genetics/qc/commit/7634a50906282cbbb34d9f6baf9c08a96c7c9416))
* somalier germline and ungrouped samples ([efe0270](https://github.com/hydra-genetics/qc/commit/efe02700fb919625ae42e36686b4c46acd9c4f98))
* somalier patch ([7574ec3](https://github.com/hydra-genetics/qc/commit/7574ec3e354a07caf05a5d0a15976d35acc6aa9e))
* somalier trio patch ([42e7cbf](https://github.com/hydra-genetics/qc/commit/42e7cbf881677c0aac3ee3b6c57e5a94b2ef9b05))
* somalier_matched, module for matched samples ([91f2892](https://github.com/hydra-genetics/qc/commit/91f28927155628acc14a5015582b490f9c3617f2))
* **somalier_trio:** add create group and validation scripts ([397d35f](https://github.com/hydra-genetics/qc/commit/397d35f7bb14160e40185b1db961e6de47cbacda))
* **somalier:** update to take both matched and unmatched samples ([16545d9](https://github.com/hydra-genetics/qc/commit/16545d9e5e1ebbf7aacc85a29dd38719d813e056))
* split somalier functions into modules ([533f8b5](https://github.com/hydra-genetics/qc/commit/533f8b570d63e52927e3507ee262880061ab7fb9))
* update docker version ([3ef2f3d](https://github.com/hydra-genetics/qc/commit/3ef2f3d96edd7ea802a305fdbe84340382847207))


### Bug Fixes

* add create ped ([433dacb](https://github.com/hydra-genetics/qc/commit/433dacb34106a65ef47d48f4bec867193d7586e7))
* add create ped with trio info ([1651ce3](https://github.com/hydra-genetics/qc/commit/1651ce3fef68b43e86eca51122e96455e1f7c271))
* add fai input; add failsafe for incorrect bam naming ([69c7c15](https://github.com/hydra-genetics/qc/commit/69c7c1578193d98ea967d9005e1391244bfb655d))
* add failsafes for pattern matching ([b0dd686](https://github.com/hydra-genetics/qc/commit/b0dd6869a63e46f29ea02fdfe438869857615cb8))
* add missing config ([92d4bdf](https://github.com/hydra-genetics/qc/commit/92d4bdf22dea136828c94050b4eea5d0996f94f4))
* add missing container ([22b4ccb](https://github.com/hydra-genetics/qc/commit/22b4ccb6b0f21dc3919a32da07abbfee330fed5f))
* add missing function import ([e59077d](https://github.com/hydra-genetics/qc/commit/e59077dcf0bcc60f3f7487bec21987bd9b256c78))
* add missing rg info for RNA ([11f0217](https://github.com/hydra-genetics/qc/commit/11f021709829baec298cae06256518e6e089c400))
* add missing rg info for RNA ([f7cd2d5](https://github.com/hydra-genetics/qc/commit/f7cd2d58aeb9ac899af6d3d48e7ef14e4d9f184e))
* add missing update in resource schema ([7ee9676](https://github.com/hydra-genetics/qc/commit/7ee967629d8fbfcb3b363deeeeaede5a9ddceafb))
* add need ped file check ([aaddc47](https://github.com/hydra-genetics/qc/commit/aaddc47690315bf5b692ef58bafd14a9bf5caa0c))
* add need ped file check ([044e83b](https://github.com/hydra-genetics/qc/commit/044e83bbf68f3d52fe627dc5c6e0e883d64aec31))
* add new test files ([233817d](https://github.com/hydra-genetics/qc/commit/233817d5d726a87f1fa6c04f05d7e0f7b3373c40))
* add option of no ped file ([8ab2bf2](https://github.com/hydra-genetics/qc/commit/8ab2bf2dddae977647ffb051b9a5203b7c6e2d97))
* add option of no ped file ([4726261](https://github.com/hydra-genetics/qc/commit/472626181efec82c1119aa94838dda434f3ac1af))
* add option of no ped file ([46f17c4](https://github.com/hydra-genetics/qc/commit/46f17c466d2da7e6bff2a166411958285d2ff42d))
* add trio bam test files ([65f8d63](https://github.com/hydra-genetics/qc/commit/65f8d63166d8be370dad56c4ab70b25b36af7183))
* address CodeRabbit review - simplify PED logic and fix mqc_config ([17eb47f](https://github.com/hydra-genetics/qc/commit/17eb47f8a1a2d927baa34bf9ad1e44dd9f7e77a3))
* change to somalier specific integration testing ([524de60](https://github.com/hydra-genetics/qc/commit/524de602dc5369d49bf6050a8b78a81c7e49ff37))
* clean up unused extra parameters ([ac8e97a](https://github.com/hydra-genetics/qc/commit/ac8e97a40821fba39863b5664d003c175358990f))
* correcting decimals ([300b911](https://github.com/hydra-genetics/qc/commit/300b911d44c01f578bd249d4f62bcddbd2aff482))
* Create .release-please-manifest.json ([2fd29c5](https://github.com/hydra-genetics/qc/commit/2fd29c5862be0db93329647e737f608fe7b4ad79))
* fgbio qc output path ([fcffb23](https://github.com/hydra-genetics/qc/commit/fcffb237f823de1b45cb96ad05b60983873e0060))
* improved multiqc ([e16a1c7](https://github.com/hydra-genetics/qc/commit/e16a1c7a5aeec18d81386d691ab9ea7db911f2e4))
* make env variable for rg configurable ([a84c7b1](https://github.com/hydra-genetics/qc/commit/a84c7b12590247a25260170192fd72cae2f00a09))
* make fgbio outputs conditional based on config ([3b6cbbe](https://github.com/hydra-genetics/qc/commit/3b6cbbe269dcde0996d85b13737689862ababb4c))
* make ped creation optional ([77cb3c4](https://github.com/hydra-genetics/qc/commit/77cb3c4b55290875521b6ec676c02a9898b228f1))
* make ped creation optional ([aa99862](https://github.com/hydra-genetics/qc/commit/aa998627bc1465a18f49a0e291bc5d7a92b00f30))
* make ped creation optional ([4b18456](https://github.com/hydra-genetics/qc/commit/4b18456618f4c6217a4169e35582df8ec885f7fb))
* match new test file with pre-existing ([6b8cd95](https://github.com/hydra-genetics/qc/commit/6b8cd95c0b6a7270dcf3572ab9ecbe75085509d8))
* move requirement updates to correct file ([d198707](https://github.com/hydra-genetics/qc/commit/d19870750d90c32c3ab6776e2f98ff3f15fc4bf1))
* move rule path to qc from alignment ([d41ab18](https://github.com/hydra-genetics/qc/commit/d41ab18b83b2928d33fe840ba0172bc803f1076f))
* recreate bam index after updating bam file sm tags ([3f404b0](https://github.com/hydra-genetics/qc/commit/3f404b09cbb3e79120e044c5c980563b07f66f40))
* redirect att to log ([d81c755](https://github.com/hydra-genetics/qc/commit/d81c755e6fc6f8705b879348cf4620490cfab8b3))
* reduce multiqc to minimal input for testing ([57f6fee](https://github.com/hydra-genetics/qc/commit/57f6fee67f28df1d65914c2c5cb9e7a95780a2c5))
* remove duplicate if statement ([60ed0d5](https://github.com/hydra-genetics/qc/commit/60ed0d5742e138e0864845311e0e86738d8542e5))
* remove hard coded sex reporting; add sex mapping ([db29fb9](https://github.com/hydra-genetics/qc/commit/db29fb91d321adc587eb954bd6ec51313a5d87b5))
* remove non-ASCII-character ([6411960](https://github.com/hydra-genetics/qc/commit/64119605bae508496daf4b645152dbf24dbd40e4))
* remove old module ([767108c](https://github.com/hydra-genetics/qc/commit/767108cf5eee74ce98313cb4305e4d1d3392aede))
* remove old somalier test files ([ebefd46](https://github.com/hydra-genetics/qc/commit/ebefd4663ce6f917e724e0b61d9b4a5d77f80773))
* remove redundant log directory creation in rseqc rules ([647f3de](https://github.com/hydra-genetics/qc/commit/647f3de76f478e0c8c7795b89649f2748dd75635))
* remove unnecessary tmp redirection ([e5b30c4](https://github.com/hydra-genetics/qc/commit/e5b30c46468eab435b95c22ed6b52168749c0538))
* remove unused parameter ([f9777e1](https://github.com/hydra-genetics/qc/commit/f9777e1e45e143e1d577282f35a7d92dbd6a94db))
* remove unused properties ([2fe6418](https://github.com/hydra-genetics/qc/commit/2fe6418d23c8da3c8a84728de4f41b980003b0f7))
* remove unused property ([db0f194](https://github.com/hydra-genetics/qc/commit/db0f194fb09545ee15030311040e6deb3236a9aa))
* remove unused variable ([815d2ed](https://github.com/hydra-genetics/qc/commit/815d2ed42387b0860a000f8369889cf5edaabd12))
* rm pdf file output ([0f1c268](https://github.com/hydra-genetics/qc/commit/0f1c268eb321e88dd16282a18164bd2bc1fe3dc5))
* rule input name ([75d294b](https://github.com/hydra-genetics/qc/commit/75d294b1da86101abf62f4b7e1f499d3e800d7a4))
* sample name in summary output ([4b7b22a](https://github.com/hydra-genetics/qc/commit/4b7b22ae6e5658f732a4a3d25cd108b06e6c9280))
* solve absolute path issue ([da2919f](https://github.com/hydra-genetics/qc/commit/da2919fefe74112b422c46eca024a4fe0698e4f9))
* solve coderabbit issues ([5720495](https://github.com/hydra-genetics/qc/commit/5720495180b6ab7674a7ae7401d94246fadd315c))
* solve data passing to multiqc ([664402c](https://github.com/hydra-genetics/qc/commit/664402ca9015fe94cf94b48e71bb2a90a9fd6036))
* solve incompatibility problems in requirements ([5de4e74](https://github.com/hydra-genetics/qc/commit/5de4e741353dbb107d399e4761201584e5c32fe5))
* solve integration test compatibility ([ed991c8](https://github.com/hydra-genetics/qc/commit/ed991c8086db3fb138fc87436fe416ad09d44e9b))
* solve key error ([6422513](https://github.com/hydra-genetics/qc/commit/642251370e2f795254e3b114e968edd257814ce4))
* solve missing directory ([69c70d6](https://github.com/hydra-genetics/qc/commit/69c70d6e01361068160594b1e496c2fa797bf66a))
* solve somalier specific integration testing ([7a7f24e](https://github.com/hydra-genetics/qc/commit/7a7f24eb49ce5974b7257247214e393aa938ff66))
* solve test issues ([fa2b8a5](https://github.com/hydra-genetics/qc/commit/fa2b8a54755fa01e83d09763200974e6b7c83dd9))
* **somalier_matched:** removed unused functions ([487e7d6](https://github.com/hydra-genetics/qc/commit/487e7d6df31e18fd00d7e45b7355657b6745dadb))
* **somalier:** update testfiles, simplify extract rule ([2620026](https://github.com/hydra-genetics/qc/commit/26200266b10b189c4e80682dc79436b0a3b5bcab))
* squish create ped to one rule ([6424515](https://github.com/hydra-genetics/qc/commit/6424515afc22a295df29d92f54eb99dc6b42d05b))
* update after code review ([5eecea9](https://github.com/hydra-genetics/qc/commit/5eecea9a923d61fd1f7c3b75134d1305754dba2d))
* update CI action compatibility ([ec2df6d](https://github.com/hydra-genetics/qc/commit/ec2df6d0e7dd22e7daf887c1146cbad41a9b1946))
* update config ([c7ced92](https://github.com/hydra-genetics/qc/commit/c7ced928d6ac94e03c9c3f71af486fbe9e11bddf))
* update configs and config references ([dc39f68](https://github.com/hydra-genetics/qc/commit/dc39f684745ef83b968f53abd43e5d62289605df))
* update docker version ([ea6b582](https://github.com/hydra-genetics/qc/commit/ea6b58286eb54fda0da46c04142ea022068893aa))
* update fasta index ([88ffefb](https://github.com/hydra-genetics/qc/commit/88ffefb84a83cfdcec0bda465a075ffc07a79607))
* update files to match updated integration test data ([5a91a95](https://github.com/hydra-genetics/qc/commit/5a91a9507e9eee34b89d10ae6d481527f95fa516))
* update for paired samples ([ee9e46e](https://github.com/hydra-genetics/qc/commit/ee9e46e26e9b06e3f4a511b6b242cfad268485ea))
* update for trios ([4288007](https://github.com/hydra-genetics/qc/commit/4288007ab6e1a62e0cbbcfffb11b1048253357a4))
* update paths ([fe6ae88](https://github.com/hydra-genetics/qc/commit/fe6ae8826028e32770f0a2fe32998ccdb0221187))
* update paths and reference ([9ef7bcd](https://github.com/hydra-genetics/qc/commit/9ef7bcdae532b35b03ad8114652b6550a723f793))
* Update release-please.yaml ([8894913](https://github.com/hydra-genetics/qc/commit/88949138e0adfa0c1ed2dedcd9e849d83e667812))
* Update release-please.yaml ([f772aa4](https://github.com/hydra-genetics/qc/commit/f772aa4788abc11b5b544f49fdd03c598cf09894))
* Update release-please.yaml ([ffbb96e](https://github.com/hydra-genetics/qc/commit/ffbb96eb533fd53a9eb6d4af9c17ade09319af74))
* update rules to match ped function ([efccc33](https://github.com/hydra-genetics/qc/commit/efccc33cee88938a6a94f64036205ccfbbdd4dd5))
* update rules to match ped function ([821b40c](https://github.com/hydra-genetics/qc/commit/821b40cb23bd2ab419585714d73d2c000c9c2284))
* update schema to match new rule implementation ([5d9bd3d](https://github.com/hydra-genetics/qc/commit/5d9bd3d3d0ec1fa7800378fa294d828c88cdb169))
* update schemas with trio info ([129adae](https://github.com/hydra-genetics/qc/commit/129adaef143a88ac3dac3822399210af23cabd61))
* update SM tags to match samples.tsv ([878a28c](https://github.com/hydra-genetics/qc/commit/878a28cc490673937139428e4330e2d0f2c5c37d))
* update softwares.md with somalier trio info ([14b5cc0](https://github.com/hydra-genetics/qc/commit/14b5cc0382762e968b1761ac3f239846fef37e5e))
* update test script ([baa435a](https://github.com/hydra-genetics/qc/commit/baa435aaf845142245b261d0ad87ff71049e852e))
* update test sites ([738f007](https://github.com/hydra-genetics/qc/commit/738f007e8b6276136b59fb19d7bb33d305cb06f6))
* update to correct config paths ([8b67811](https://github.com/hydra-genetics/qc/commit/8b67811bfae80dff7b0d8215d59b986ec51ac579))
* update to empty file ([f6ad134](https://github.com/hydra-genetics/qc/commit/f6ad1340fc986e96e01397e8af0d0095aed39ea9))
* update to latest hydra-genetics release (3.3.0) ([8448d1d](https://github.com/hydra-genetics/qc/commit/8448d1d15b442f8acc2d2978d1cece2a9d7144f7))
* update to match new rule structure ([6847d66](https://github.com/hydra-genetics/qc/commit/6847d6632719b81094eea6413554d1499b1d95f6))
* use helper function for samples input to fix mkdocs parsing ([450df23](https://github.com/hydra-genetics/qc/commit/450df232e69cb6a6e237b20d3d6efcbc4027d226))


### Reverts

* rseqc.smk changes ([13d3c08](https://github.com/hydra-genetics/qc/commit/13d3c080e9a7ec1766956b735d132910a00bf2c0))


### Documentation

* missing docs ([04250ae](https://github.com/hydra-genetics/qc/commit/04250ae4c40a7fc3d6fc2c3117d98aff369cf3f0))
* rm pdf from schemas ([1dedaa1](https://github.com/hydra-genetics/qc/commit/1dedaa14def36b07ef29125dce4ff3a5d2b5a2b3))
* update somalier documentation ([7d7c1ba](https://github.com/hydra-genetics/qc/commit/7d7c1ba6e67a3fa881ebc279d20b02ae5e93c26e))
* update somalier documentation ([7dc2612](https://github.com/hydra-genetics/qc/commit/7dc2612b156d0a5a7818248d67f6faaec17e7837))
* update somalier documentation ([d15f400](https://github.com/hydra-genetics/qc/commit/d15f400a33c2e7154b793d4425facfb1269c8400))

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
