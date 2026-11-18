// compile the code before running: 
// type mvn clean compile in terminal

package org.example;

// General Helper Imports
import manifold.sql.rt.api.Dependencies.*;
import java.sql.SQLException;
import java.util.List;
import static java.lang.System.out;
import java.nio.file.*;


// Import all defined queries
import org.example.queries.*;

// Import schema classes
import org.example.schema.CMS;
import org.example.schema.CMS.*;



public class Main {
    public static void main(String[] args) {

      try {
        // Load in all the data from CSV files in to in-memory DuckDB
        loadCMSData();

        // Example: fetch a student by ID and print their email
        Student s = Student.fetch(9002);
        out.println(s.getEmail());
        // Example: fetch the same student using a parameterized SQL query
        Student s2 = FindStudent.fetchOne(9002);
        out.println(s2.getEmail());

        //Example: saving a table to CSV
        CMS.addSqlChange(ctx -> {
          SaveStudents.execute(ctx);
        });
        CMS.commit();
        
        // EXTRA MAIN FUNCTION CALLS CAN GO BELOW:
        List<GradCourses.Row> gradCourses_list = getGradCourses(); // print out gradCourses
        for (GradCourses.Row course : gradCourses_list) {
          out.println(course.getCourseId() + " " + course.getCourseName());
        }
        saveGradCourses();
        runQuery1();
        runQuery2();
        runQuery3();
        runQuery4();
        runQuery5();
        runQuery6();
        runQuery7();
        runQuery8();
        
      }
      catch (Exception e) {
        e.printStackTrace();
      }


  }

  public static void loadCMSData() throws SQLException {
    loadStudentData();
    loadProfessorData();
    loadCourseData();
    loadTranscriptData();
    loadTeachesData();
  }

  public static void loadStudentData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadStudents.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadProfessorData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadProfessors.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadCourseData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadCourses.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadTranscriptData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadTranscript.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadTeachesData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadTeaches.execute(ctx);
    });
    CMS.commit();
  }

  public static List<GradCourses.Row> getGradCourses() throws SQLException {
    List<GradCourses.Row> courses_list = new java.util.ArrayList<>();
    for (GradCourses.Row row: GradCourses.fetch()) {
      courses_list.add(row);
    }
    return courses_list;
  }

  // SQL file to select and export, java method to execute.  
  public static void saveGradCourses() throws SQLException {
    CMS.addSqlChange(ctx -> {
      SaveGradCourses.execute(ctx);
    });
    CMS.commit();
  }

  // each each method runQueryi runs queryi where i = {1,2,3,4,5,6,7,8}
  public static void runQuery1() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query1.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery2() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query2.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery3() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query3.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery4() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query4.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery5() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query5.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery6() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query6.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery7() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query7.execute(ctx);
    });
    CMS.commit();
  }

  public static void runQuery8() throws SQLException {
    CMS.addSqlChange(ctx -> {
      query8.execute(ctx);
    });
    CMS.commit();
  }
}