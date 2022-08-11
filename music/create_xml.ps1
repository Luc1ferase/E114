$genre = @{
    101="POPS＆アニメ";
    102="niconicoボーカロイド";
    103="東方Project";
    104="ゲームバラエティ";
    105="maimai";
    106="オンゲキCHUNITHM";
};

$template = @"
<?xml version="1.0" encoding="utf-8"?>
<MusicData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <dataName>music{0:000000}</dataName>
  <netOpenName>
    <id>220324</id>
    <str>Net220324</str>
  </netOpenName>
  <releaseTagName>
    <id>2501</id>
    <str>Ver1.25.00</str>
  </releaseTagName>
  <disable>false</disable>
  <name>
    <id>{0:000000}</id>
    <str>{1}</str>
  </name>
  <sortName>{0}</sortName>
  <artistName>
    <id>1{0}</id>
    <str>{2}</str>
  </artistName>
  <genreName>
    <id>{9}</id>
    <str>{10}</str>
  </genreName>
  <bpm>{3}</bpm>
  <version>22501</version>
  <AddVersion>
    <id>999</id>
    <str>CUSTOM</str>
  </AddVersion>
  <movieName>
    <id>1{11:0000}</id>
    <str>{1}</str>
  </movieName>
  <cueName>
    <id>{11:0000}</id>
    <str>{1}</str>
  </cueName>
  <dresscode>false</dresscode>
  <eventName>
    <id>1</id>
    <str>無期限常時解放</str>
  </eventName>
  <subEventName>
    <id>1</id>
    <str>無期限常時解放</str>
  </subEventName>
  <lockType>0</lockType>
  <subLockType>0</subLockType>
  <dotNetListView>true</dotNetListView>
  <notesData>
    <Notes>
      <file>
        <path>{0:000000}_00.ma2</path>
      </file>
      <level>0</level>
      <levelDecimal>0</levelDecimal>
      <notesDesigner>
        <id>0</id>
        <str />
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>0</musicLevelID>
      <maxNotes>0</maxNotes>
      <isEnable>false</isEnable>
    </Notes>
    <Notes>
      <file>
        <path>{0:000000}_01.ma2</path>
      </file>
      <level>0</level>
      <levelDecimal>0</levelDecimal>
      <notesDesigner>
        <id>0</id>
        <str />
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>0</musicLevelID>
      <maxNotes>0</maxNotes>
      <isEnable>false</isEnable>
    </Notes>
    <Notes>
      <file>
        <path>{0:000000}_02.ma2</path>
      </file>
      <level>0</level>
      <levelDecimal>0</levelDecimal>
      <notesDesigner>
        <id>0</id>
        <str />
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>0</musicLevelID>
      <maxNotes>0</maxNotes>
      <isEnable>false</isEnable>
    </Notes>
    <Notes>
      <file>
        <path>{0:000000}_03.ma2</path>
      </file>
      <level>{4}</level>
      <levelDecimal>{5}</levelDecimal>
      <notesDesigner>
        <id>100{0}</id>
        <str>{6}</str>
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>{7}</musicLevelID>
      <maxNotes>{8}</maxNotes>
      <isEnable>true</isEnable>
    </Notes>
    <Notes>
      <file>
        <path>{0:000000}_04.ma2</path>
      </file>
      <level>0</level>
      <levelDecimal>0</levelDecimal>
      <notesDesigner>
        <id>0</id>
        <str />
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>0</musicLevelID>
      <maxNotes>0</maxNotes>
      <isEnable>false</isEnable>
    </Notes>
    <Notes>
      <file>
        <path>{0:000000}_05.ma2</path>
      </file>
      <level>0</level>
      <levelDecimal>0</levelDecimal>
      <notesDesigner>
        <id>0</id>
        <str />
      </notesDesigner>
      <notesType>0</notesType>
      <musicLevelID>0</musicLevelID>
      <maxNotes>0</maxNotes>
      <isEnable>false</isEnable>
    </Notes>
  </notesData>
  <jacketFile />
  <thumbnailName />
  <rightFile />
  <priority>0</priority>
</MusicData>
"@;

echo id:
$id = [int]::Parse((Read-Host))
$mid = $id % 10000
echo name:
$name = Read-Host
echo artist:
$artist = Read-Host
echo bpm:
$bpm = [int]::Parse((Read-Host))
echo level:
$levelFull = [float]::Parse((Read-Host))

$levelId = 0
$level = 0
$levelDec = 0

if($levelFull -lt 7.7) {
  $levelId = [int]$levelFull
} else {
  $level = [int]$levelFull
  $levelDec = [int](($levelFull * 10) % 10)

  $levelId = 7 + ($level - 8) * 2;
  if($levelDec -ge 7) {
    $levelId = $levelId + 1
  }
}

echo note designer:
$designer = Read-Host
echo note count
$noteCount = [int]::Parse((Read-Host))
echo category
$category = [int]::Parse((Read-Host))

$out = $template -f $id, $name, $artist, $bpm, $level, $levelDec, $designer, $levelId, $noteCount, $category, $genre[$category], $mid

mkdir ("music{0:000000}" -f $id)
[IO.File]::WriteAllLines(("music{0:000000}\Music.xml" | Resolve-Path), $out)
