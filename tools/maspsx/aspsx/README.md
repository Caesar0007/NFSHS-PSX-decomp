# ASPSX Tests

The idea of this directory is to leverage unit tests to catalog the various differences between ASPSX versions.


## Running the tests

[dos2emu2](https://github.com/dosemu2/dosemu2) is required to run the 16 bit ASPSX versions, `wine` is required to run the 32bit ASPSX versions.

```
sudo add-apt-repository ppa:dosemu2/ppa
sudo apt update
sudo apt-get install dosemu2 wine
```

Run `download.sh` to pull down all the psyq assemblers, and then `python3 -m unittest` to run the tests.
