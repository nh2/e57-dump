#include <iostream>

#include <E57Format/E57Format.h>

int main(int argc, char const *argv[])
{
  using namespace std;

  if (argc < 2) {
    cerr << "Usage: e57-dump FILE.e57" << endl;
    return 1;
  }

  try {
    e57::ImageFile imageFile(argv[1], "r");
    imageFile.root().dump();
  } catch (const e57::E57Exception& e) {
    // `E57Exception::what()` does not contain any detail, so we extract
    // it manually and rethrow. See:
    //     https://github.com/asmaloney/libE57Format/blob/f859e975cc7c397f081b59bfe3b13054f25931b1/src/E57Exception.cpp#L197-L200
    std::string errmsg =
      std::string(e.what()) + ": " +
      e57::Utilities::errorCodeToString( e.errorCode() ) +
      "; context: " + e.context();
    throw runtime_error(errmsg);
  }

  return 0;
}
